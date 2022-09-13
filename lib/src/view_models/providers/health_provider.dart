import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:news_app/src/models/news_articles/news_articles.dart';

import '../../services/api_services.dart';

enum HealthState { inital, loading, loaded, error }


class HealthProvider extends ChangeNotifier {

    late String _errorMessage;
  String get errorMessage => _errorMessage;

  int _page = 1;
  int _pageSize = 5;

  List<NewsArticles> _healthArticels = [];
  List<NewsArticles> get healthArticles => _healthArticels;

  HealthState _healthState = HealthState.inital;
  HealthState get healthState => _healthState;

  Future<List<NewsArticles>> getArticles(
      {required String category, required bool isRefreshed}) async {
    try {
      _healthState = HealthState.loading;
      await Future.delayed(const Duration(seconds: 2));

      List<NewsArticles> newsData = await ApiServices().getNewsResponse(
          page: _page, pageSize: _pageSize, category: category);

      if (!isRefreshed) {
        _healthArticels = newsData;
        notifyListeners();
        _healthState = HealthState.loaded;
      } else {
        if (_pageSize <= 100) {
          _pageSize = _pageSize += 10;
          _healthArticels.addAll(newsData);

          _healthState = HealthState.loaded;

          if (_pageSize == 100) {
            _pageSize = 20;
            // _healthArticels!.addAll(newsData);
            _healthArticels = newsData;
            _healthState = HealthState.loaded;
          }
        }
      }
    } catch (e) {
      Logger().d(e.toString());
      _errorMessage = e.toString();
      _healthState = HealthState.error;
    }
    notifyListeners();

    return _healthArticels;
  }
}
