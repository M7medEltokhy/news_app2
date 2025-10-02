import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/search/cubit/search_state.dart';
import 'package:news_app/features/search/data/search_repo.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required this.searchRepo}) : super(SearchInitial());
  final SearchRepoImpl searchRepo;
  void getArticalesBySearch({
    required String query,
    required String language,
  }) async {
    emit(SearchLoading());
    final articales = await searchRepo.getArticalesBySearch(
      query: query,
      language: language,
    );
    articales.fold(
      (errorMassage) => emit(SearchFailure(errorMessage: errorMassage)),
      (articales) => emit(SearchSuccess(articles: articales)),
    );
  }
}
