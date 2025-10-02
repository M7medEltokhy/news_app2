import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/theme/cubit/theme_cubit.dart';
import 'package:news_app/core/utils/app_color.dart';
import 'package:news_app/core/utils/app_constants.dart';
import 'package:news_app/features/home_layout/cubit/home_layout_cubit.dart';
import 'package:news_app/features/home_layout/screens/home_layout_screen.dart';
import 'package:news_app/features/setting/screens/setting_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('ar'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => HomeLayoutCubit()),
            BlocProvider(create: (context) => ThemeCubit()),
          ],
          child: Builder(
            builder: (context) {
              return MaterialApp(
                theme: ThemeData(
                  fontFamily: 'Newsreader',
                  brightness: Brightness.light,
                  cardColor: Colors.white,
                  textTheme: const TextTheme(
                    bodyLarge: TextStyle(color: Colors.black, fontSize: 16),
                    bodyMedium: TextStyle(color: Colors.black87, fontSize: 14),
                  ),
                  scaffoldBackgroundColor: AppColor.backgroundColor,
                ),
                darkTheme: ThemeData(
                  brightness: Brightness.dark,
                  scaffoldBackgroundColor: Colors.black,
                  cardColor: const Color(0xFF1E1E1E),
                  textTheme: const TextTheme(
                    bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
                    bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ),
                themeMode: context.watch<ThemeCubit>().state,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                initialRoute: homeLayout,
                routes: {
                  homeLayout: (_) => HomeLayoutScreen(),
                  settingScreen: (_) => SettingScreen(),
                },
              );
            },
          ),
        );
      },
    );
  }
}
