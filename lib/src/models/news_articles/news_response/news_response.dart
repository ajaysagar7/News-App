import 'package:json_annotation/json_annotation.dart';
import 'package:news_app/src/models/news_articles/news_articles.dart';

part 'news_response.g.dart';

@JsonSerializable()
class NewsResponse {
  final String status;
  final int totalResults;
  final List<NewsArticles> articles;
  NewsResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) =>
      _$NewsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NewsResponseToJson(this);
}
