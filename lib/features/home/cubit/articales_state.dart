import 'package:news_app/features/home/data/home_model.dart';

class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<ArticaleModel> articles;
  final String title;
  HomeSuccess({required this.articles, required this.title});
}

class HomeFailure extends HomeState {
  final String errorMessage;
  HomeFailure({required this.errorMessage});
}
