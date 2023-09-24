import 'package:equatable/equatable.dart';

class NewsEntity extends Equatable {
  final String title;
  final String description;
  final String publishedAt;
  final String url;
  final String? urlToImage;
  final String? author;
  final String? content;
  final String? source;

  //constructor
  const NewsEntity(
      {required this.title,
      required this.description,
      required this.publishedAt,
      required this.url,
      this.urlToImage,
      this.author,
      this.content,
      this.source});

  //hash code for equality
  @override
  List<Object?> get props => [
        title,
        description,
        publishedAt,
        url,
        urlToImage,
        author,
        content,
        source
      ];
}
