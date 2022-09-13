// "articles": [
// -{
// -"source": {
// "id": "reuters",
// "name": "Reuters"
// },
// "author": null,
// "title": "Peloton to cut jobs, shut stores and raise prices in company-wide revamp - Reuters.com",
// "description": "Peloton Interactive Inc <a href=\"https://www.reuters.com/companies/PTON.O\" target=\"_blank\">(PTON.O)</a> said on Friday it would cut jobs, shut stores and raise prices on its exercise equipment including treadmills and top-end bikes as it undertakes a company-…",
// "url": "https://www.reuters.com/business/retail-consumer/peloton-raises-bike-prices-united-states-canada-2022-08-12/",
// "urlToImage": "https://www.reuters.com/resizer/8KlwvplxnTBnZoQQjAHLfQ0xnfI=/1200x628/smart/filters:quality(80)/cloudfront-us-east-2.images.arcpublishing.com/reuters/BQ5AQZ2YBJN6TENSSHASHY3K5Q.jpg",
// "publishedAt": "2022-08-13T10:29:00Z",
// "content": "Aug 12 (Reuters) - Peloton Interactive Inc (PTON.O) said on Friday it would cut jobs, shut stores and raise prices on its exercise equipment including treadmills and top-end bikes as it undertakes a … [+1636 chars]"
// },

import 'package:json_annotation/json_annotation.dart';
import 'package:news_app/src/models/news_sources/news_sources.dart';

part 'news_articles.g.dart';

@JsonSerializable(explicitToJson: true)
class NewsArticles {
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;
  NewsSource? source;
  NewsArticles({
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
    this.source,
  });

  factory NewsArticles.fromJson(Map<String, dynamic> json) =>
      _$NewsArticlesFromJson(json);

  Map<String, dynamic> toJson() => _$NewsArticlesToJson(this);
}
