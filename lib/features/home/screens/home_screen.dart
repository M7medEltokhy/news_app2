import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/core/utils/app_color.dart';
import 'package:news_app/features/home/cubit/articales_cubit.dart';
import 'package:news_app/features/home/cubit/articales_state.dart';
import 'package:news_app/features/home/screens/articale_web_view_screen.dart';
import 'package:news_app/features/home/widgets/articale_card_list.dart';
import 'package:news_app/features/home/widgets/custom_loading.dart';
import 'package:news_app/features/home/widgets/no_articles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _lastLang;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final currentLang = context.locale.languageCode;
    if (_lastLang != currentLang) {
      _lastLang = currentLang;
      context.read<HomeCubit>().getArticales(
        category: 'news',
        language: currentLang,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: SvgPicture.asset(
            'assets/svgs/articale_icon.svg',
            height: 20,
            width: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settingScreen');
            },
            icon: SvgPicture.asset('assets/svgs/setting.svg'),
          ),
        ],
        surfaceTintColor: Colors.transparent,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'news'.tr(),
              style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.secondaryColor,
              ),
            ),
            Text(
              'today'.tr(),
              style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.titleColor,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, state) =>
            state is HomeLoading ||
            state is HomeSuccess ||
            state is HomeFailure,
        builder: (context, state) {
          if (state is HomeLoading) {
            return SizedBox(
              width: size.width,
              child: Column(
                children: [
                  ArticaleCardList(),
                  SizedBox(height: 170.h),
                  CustomLoading(),
                ],
              ),
            );
          } else if (state is HomeSuccess) {
            if (state.articles.isEmpty) {
              return Column(
                children: [
                  ArticaleCardList(),
                  SizedBox(height: 100.h),
                  NoArticles(size: size),
                ],
              );
            }
            return Column(
              children: [
                ArticaleCardList(),
                Expanded(
                  child: RefreshIndicator(
                    color: AppColor.secondaryColor,
                    backgroundColor: AppColor.backgroundColor,
                    strokeWidth: 3,
                    onRefresh: () async {
                      final currentLang = context.locale.languageCode;
                      final cubit = context.read<HomeCubit>();
                      cubit.getArticales(
                        category: (cubit.state as HomeSuccess).title,
                        language: currentLang,
                      );
                    },
                    child: ListView.builder(
                      itemCount: state.articles.length,
                      itemBuilder: (context, index) {
                        final article = state.articles[index];
                        return InkWell(
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
                            color: AppColor.borderColor,
                            margin: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: CachedNetworkImage(
                                    imageUrl: article.urlToImage ?? '',
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      color: Colors.grey.shade300,
                                      child: const Icon(
                                        Icons.image,
                                        size: 40,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                          color: Colors.grey.shade300,
                                          child: const Icon(
                                            Icons.broken_image,
                                            size: 40,
                                            color: Colors.grey,
                                          ),
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        article.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        article.description ?? '',
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          } else if (state is HomeFailure) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
