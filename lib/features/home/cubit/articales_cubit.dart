import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/cubit/articales_state.dart';
import 'package:news_app/features/home/data/home_repo.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.homeRepo}) : super(HomeInitial());
  final HomeRepoImpl homeRepo;
  void getArticales({
    required String category,
    required String language,
  }) async {
    emit(HomeLoading());
    final articales = await homeRepo.getArticales(
      category: category,
      language: language,
    );
    articales.fold(
      (errorMassage) => emit(HomeFailure(errorMessage: errorMassage)),
      (articales) => emit(HomeSuccess(articles: articales, title: category)),
    );
  }

  // void SelectedCard({required String title}) {
  //   emit(ArticalesCardSelected(title: title));
  // }
}
