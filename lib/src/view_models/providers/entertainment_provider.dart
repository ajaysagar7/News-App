




import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../models/news_articles/news_articles.dart';
import '../../services/api_services.dart';
enum EnterainmentState { inital, loading, loaded, error }


class EnterainmentProvider extends ChangeNotifier {

    late String _errorMessage;
  String get errorMessage => _errorMessage;

  int _page = 1;
  int _pageSize = 5;

  List<NewsArticles> _healthArticels = [];
  List<NewsArticles> get healthArticles => _healthArticels;

  EnterainmentState _enterainmentState = EnterainmentState.inital;
  EnterainmentState get entertainmentState => _enterainmentState;

  Future<List<NewsArticles>> getArticles(
      {required String category, required bool isRefreshed}) async {
    try {
      _enterainmentState = EnterainmentState.loading;
      await Future.delayed(const Duration(seconds: 2));

      List<NewsArticles> newsData = await ApiServices().getNewsResponse(
          page: _page, pageSize: _pageSize, category: category);

      if (!isRefreshed) {
        _healthArticels = newsData;
        notifyListeners();
        _enterainmentState = EnterainmentState.loaded;
      } else {
        if (_pageSize <= 100) {
          _pageSize = _pageSize += 10;
          _healthArticels.addAll(newsData);

          _enterainmentState = EnterainmentState.loaded;

          if (_pageSize == 100) {
            _pageSize = 20;
            // _healthArticels!.addAll(newsData);
            _healthArticels = newsData;
            _enterainmentState = EnterainmentState.loaded;
          }
        }
      }
    } catch (e) {
      Logger().d(e.toString());
      _errorMessage = e.toString();
      _enterainmentState = EnterainmentState.error;
    }
    notifyListeners();

    return _healthArticels;
  }
}
