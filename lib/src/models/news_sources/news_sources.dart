


import 'package:json_annotation/json_annotation.dart';

part 'news_sources.g.dart';

@JsonSerializable()
class NewsSource {
  String? id;
  String? name;
  NewsSource({
    this.id,
    this.name,
  });

  factory NewsSource.fromJson(Map<String, dynamic> json) =>
      _$NewsSourceFromJson(json);

  Map<String, dynamic> toJson() => _$NewsSourceToJson(this);
}
