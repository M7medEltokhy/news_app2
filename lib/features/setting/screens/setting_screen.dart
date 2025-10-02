import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/theme/cubit/theme_cubit.dart';
import 'package:news_app/core/utils/app_color.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'settings'.tr(),
          style: TextStyle(
            fontSize: 25.sp,
            color: AppColor.titleColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.language, color: Colors.blue),
            title: Text(
              'Language'.tr(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            trailing: DropdownButton<String>(
              dropdownColor: Colors.white,
              focusColor: Colors.transparent,
              value: context.locale.languageCode == 'en'
                  ? 'English'
                  : 'العربية',
              underline: SizedBox(),
              items: [
                DropdownMenuItem(value: 'English', child: Text('English')),
                DropdownMenuItem(value: 'العربية', child: Text('العربية')),
              ],
              onChanged: (value) {
                if (value == 'English') {
                  context.setLocale(Locale('en'));
                } else if (value == 'العربية') {
                  context.setLocale(Locale('ar'));
                }
              },
            ),
          ),

          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: Text(
              'Theme'.tr(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            trailing: DropdownButton<ThemeMode>(
              value: context.watch<ThemeCubit>().state,
              items: const [
                DropdownMenuItem(value: ThemeMode.light, child: Text("Light")),
                DropdownMenuItem(value: ThemeMode.dark, child: Text("Dark")),
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text("System"),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  context.read<ThemeCubit>().setTheme(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
