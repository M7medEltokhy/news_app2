import 'package:news_app/features/home/data/home_model.dart';

List<ArticaleModel> removeDuplicates(List<ArticaleModel> articles) {
  final seen = <String>{};
  return articles.where((article) {
    final key = '${article.url}_${article.title}';
    if (seen.contains(key)) {
      return false;
    } else {
      seen.add(key);
      return true;
    }
  }).toList();
}