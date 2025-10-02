import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/utils/app_color.dart';
import 'package:news_app/features/home/cubit/articales_cubit.dart';
import 'package:news_app/features/home/cubit/articales_state.dart';

class ArticaleCard extends StatelessWidget {
  const ArticaleCard({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsetsDirectional.only(start: 8.w),
          child: InkWell(
            onTap: () {
              context.read<HomeCubit>().getArticales(
                category: title,
                language: context.locale.languageCode,
              );
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: state is HomeSuccess && state.title == title
                    ? AppColor.secondaryColor.withOpacity(0.25)
                    : Colors.white,
                border: state is HomeSuccess && state.title == title
                    ? Border.all(color: AppColor.titleColor)
                    : Border.all(color: AppColor.borderColor),
                borderRadius: BorderRadius.circular(12.r),
              ),
              margin: EdgeInsets.symmetric(vertical: 8.h),
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              // width: 120.w,
              child: Center(
                child: Text(
                  title.tr(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
