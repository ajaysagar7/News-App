// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_articles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsArticles _$NewsArticlesFromJson(Map<String, dynamic> json) => NewsArticles(
      author: json['author'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      url: json['url'] as String?,
      urlToImage: json['urlToImage'] as String?,
      publishedAt: json['publishedAt'] as String?,
      content: json['content'] as String?,
      source: json['source'] == null
          ? null
          : NewsSource.fromJson(json['source'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NewsArticlesToJson(NewsArticles instance) =>
    <String, dynamic>{
      'author': instance.author,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'urlToImage': instance.urlToImage,
      'publishedAt': instance.publishedAt,
      'content': instance.content,
      'source': instance.source?.toJson(),
    };
