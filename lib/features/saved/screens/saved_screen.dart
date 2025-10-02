import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/core/utils/app_color.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'saved_news'.tr(),
          style: TextStyle(
            fontSize: 25.sp,
            color: AppColor.titleColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300.h,
              child: Lottie.asset('assets/animation/no saved articles.json'),
            ),
            SizedBox(height: 20.h),
            Text(
              'no_saved'.tr(),
              style: TextStyle(
                fontSize: 22.sp,
                color: AppColor.titleColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'explore_and_save'.tr(),
              style: TextStyle(fontSize: 16.sp, color: AppColor.subTitleColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
