import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:news_app/src/models/news_articles/news_articles.dart';

import '../../services/api_services.dart';

enum GeneralState { inital, loading, loaded, error }

class GeneralProvider extends ChangeNotifier {

    late String _errorMessage;
  String get errorMessage => _errorMessage;

  int _page = 1;
  int _pageSize = 5;

  List<NewsArticles> _generalArticles = [];
  List<NewsArticles> get generalArticles => _generalArticles;

  GeneralState _generalState = GeneralState.inital;
  GeneralState get generalState => _generalState;

  Future<List<NewsArticles>> getArticles(
      {required String category, required bool isRefreshed}) async {
    try {
      _generalState = GeneralState.loading;
      await Future.delayed(const Duration(seconds: 2));

      List<NewsArticles> newsData = await ApiServices().getNewsResponse(
          page: _page, pageSize: _pageSize, category: category);

      if (!isRefreshed) {
        _generalArticles = newsData;
        notifyListeners();
        _generalState = GeneralState.loaded;
      } else {
        if (_pageSize <= 100) {
          _pageSize = _pageSize += 10;
          _generalArticles.addAll(newsData);

          _generalState = GeneralState.loaded;

          if (_pageSize == 100) {
            _pageSize = 20;
            // _generalArticles!.addAll(newsData);
            _generalArticles = newsData;
            _generalState = GeneralState.loaded;
          }
        }
      }
    } catch (e) {
      Logger().d(e.toString());
      _errorMessage = e.toString();
      _generalState = GeneralState.error;
    }
    notifyListeners();

    return _generalArticles;
  }
}
