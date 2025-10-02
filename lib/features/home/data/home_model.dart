class HomeModel {
  final String status;
  final int totalResults;
  final List<ArticaleModel> articles;

  HomeModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: json['articles']
          .map<ArticaleModel>((article) => ArticaleModel.fromJson(article))
          .toList(),
    );
  }
}

class ArticaleModel {
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;

  ArticaleModel( {
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory ArticaleModel.fromJson(Map<String, dynamic> json) {
    return ArticaleModel(
      author: json['author'],
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: DateTime.parse(json['publishedAt']),
      content: json['content'],
    );
  }
}
