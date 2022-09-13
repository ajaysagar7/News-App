import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:news_app/src/models/news_articles/news_articles.dart';
import 'package:news_app/src/models/news_articles/news_response/news_response.dart';
import 'package:news_app/src/services/api_constants.dart';

class ApiServices {
  BaseOptions baseOptions = BaseOptions(
    // baseUrl: Endpoints.basicUrl,
    connectTimeout: Endpoints.connectionTimeOut,
    receiveTimeout: Endpoints.receiveTimeOut,
    // headers: {"Authorization": Endpoints.apiKey},
  );
  late Dio dio;

  ApiServices() {
    dio = Dio(baseOptions);
  }

  Future<List<NewsArticles>> getNewsResponse(
      {required int page,
      required int pageSize,
      required String category}) async {
    List<NewsArticles> articles = [];
    var url =
        "https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=${Endpoints.apiKey}&pageSize=$pageSize&page=$page";

    try {
      final response = await dio.get(url);
      var totalResults = response.data['totalResults'];
      debugPrint(totalResults.toString());
      List responseData = response.data["articles"];
      articles = responseData.map((e) => NewsArticles.fromJson(e)).toList();
      Logger(level: Level.error).d(articles.length);
      Logger().d(articles[0].author.toString());
      Logger().d(articles[0].content.toString());
      Logger().d(articles[0].publishedAt.toString());
      Logger().d(articles[0].urlToImage.toString());
    } on DioError catch (e) {
      Logger().d(e.toString());
    } catch (e) {
      Logger().d(e.toString());
    }

    return articles;
  }
}
