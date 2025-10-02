import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/core/utils/app_color.dart';
import 'package:news_app/features/home/screens/articale_web_view_screen.dart';
import 'package:news_app/features/home/widgets/custom_loading.dart';
import 'package:news_app/features/home/widgets/no_articles.dart';
import 'package:news_app/features/search/cubit/search_cubit.dart';
import 'package:news_app/features/search/cubit/search_state.dart';
import 'package:news_app/features/search/widgets/custom_text_field.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    var size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'search'.tr(),
          style: TextStyle(
            fontSize: 25.sp,
            color: AppColor.titleColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            CustomTextField(
              hintText: 'search2'.tr(),
              suffixIcon: Icons.search,
              textInputAction: TextInputAction.search,
              controller: searchController,
              onSubmitted: (value) {
                context.read<SearchCubit>().getArticalesBySearch(
                  query: value,
                  language: context.locale.languageCode,
                );
              },
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(child: CustomLoading());
                  } else if (state is SearchFailure) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    );
                  } else if (state is SearchSuccess) {
                    if (state.articles.isEmpty) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 50.h),
                            NoArticles(size: size),
                          ],
                        ),
                      );
                    }
                    final articles = state.articles;
                    return ListView.builder(
                      itemCount: articles.length,
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: 12.h,
                            left: 4.w,
                            right: 4.w,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ArticleWebViewScreen(url: article.url),
                                ),
                              );
                            },
                            child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              elevation: 3,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12.r),
                                      bottomLeft: Radius.circular(12.r),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: article.urlToImage ?? '',
                                      width: 120.w,
                                      height: 120.w,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        width: 120.w,
                                        height: 120.w,
                                        color: Colors.grey[300],
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                            color: AppColor.secondaryColor,
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                            width: 120.w,
                                            height: 120.w,
                                            color: Colors.grey,
                                            child: Icon(
                                              Icons.broken_image,
                                              size: 40.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            article.title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.titleColor,
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          Text(
                                            article.description ?? '',
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 50.h),
                          SizedBox(
                            height: 280.h,
                            child: Lottie.asset(
                              'assets/animation/search for articles.json',
                            ),
                          ),
                          Text(
                            'search_for_news'.tr(),
                            style: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColor.titleColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
