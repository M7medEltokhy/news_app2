import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/core/utils/app_color.dart';
import 'package:news_app/features/home_layout/cubit/home_layout_cubit.dart';
import 'package:news_app/features/home_layout/cubit/home_layout_state.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
      builder: (context, state) {
        return Scaffold(
          body: context.read<HomeLayoutCubit>().screens[state.currentIndex!],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.currentIndex!,
            backgroundColor: AppColor.backgroundColor,
            selectedItemColor: AppColor.titleColor,
            unselectedItemColor: AppColor.subTitleColor,
            onTap: (index) {
              context.read<HomeLayoutCubit>().changeIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/svgs/home.svg'),
                label: 'home'.tr(),
                activeIcon: SvgPicture.asset('assets/svgs/home_active.svg'),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/svgs/search.svg'),
                label: 'search'.tr(),
                activeIcon: SvgPicture.asset('assets/svgs/search_active.svg'),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/svgs/saved.svg'),
                label: 'saved_news'.tr(),
                activeIcon: SvgPicture.asset('assets/svgs/saved_active.svg'),
              ),
            ],
          ),
        );
      },
    );
  }
}
