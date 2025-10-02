import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:news_app/core/utils/app_constants.dart';
import 'package:news_app/core/utils/article_filter.dart';
import 'package:news_app/features/home/data/home_model.dart';

abstract class SearchRepo {
  Future<Either<String, List<ArticaleModel>>> getArticalesBySearch({
    required String query,
    required String language,
  });
}

class SearchRepoImpl implements SearchRepo {
  final Dio dio = Dio();

  @override
  Future<Either<String, List<ArticaleModel>>> getArticalesBySearch({
    required String query,
    required String language,
  }) async {
    try {
      var response = await dio.get(
        '${baseUrl}everything',
        queryParameters: {
          'q': query,
          'language': language,
          'sortBy': 'publishedAt',
          'apiKey': apiKey,
        },
      );
      final data = HomeModel.fromJson(response.data);
      return Right(removeDuplicates(data.articles));
    } on DioException catch (e) {
      return Left(e.message ?? 'An error occurred');
    }
  }
}
