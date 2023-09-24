import 'package:core_news/features/news/domain/entities/news_entity.dart';

class NewsModel extends NewsEntity {
  const NewsModel(
      {required super.title,
      required super.description,
      required super.publishedAt,
      required super.url,
      super.author,
      super.content,
      super.source,
      super.urlToImage});

  factory NewsModel.fromJson(Map<String, dynamic> json, sourceIsObject) {
    var model = NewsModel(
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        publishedAt: json['publishedAt'] ?? '',
        url: json['url'] ?? '',
        author: json['author'],
        content: json['content'],
        source: (sourceIsObject ? json['source']['name'] : json['source']),
        urlToImage: json['urlToImage']);

    return model;
  }

  Map<String, dynamic> toJson() {
    var jsonObj = {
      "title": title,
      "description": description,
      "publishedAt": publishedAt,
      "url": url,
      "author": author,
      "content": content,
      "source": source,
      "urlToImage": urlToImage
    };
    return jsonObj;
  }
}
