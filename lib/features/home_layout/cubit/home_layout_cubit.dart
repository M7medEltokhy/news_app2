import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/cubit/articales_cubit.dart';
import 'package:news_app/features/home/data/home_repo.dart';
import 'package:news_app/features/home/screens/home_screen.dart';
import 'package:news_app/features/home_layout/cubit/home_layout_state.dart';
import 'package:news_app/features/saved/screens/saved_screen.dart';
import 'package:news_app/features/search/cubit/search_cubit.dart';
import 'package:news_app/features/search/data/search_repo.dart';
import 'package:news_app/features/search/screens/search_screen.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutState> {
  HomeLayoutCubit() : super(HomeLayoutInitial(0));

  List<Widget> screens = [
    BlocProvider(
      create: (context) => HomeCubit(homeRepo: HomeRepoImpl()),
      child: HomeScreen(),
    ),
    BlocProvider(
      create: (context) => SearchCubit(searchRepo: SearchRepoImpl()),
      child: SearchScreen(),
    ),
    SavedScreen(),
  ];
  void changeIndex(int index) {
    emit(HomeLayoutState(index));
  }
}
