import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

import '../../models/news_articles/news_articles.dart';
import '../../services/api_services.dart';

enum SportsState { inital, loading, loaded, error }

class SportsProvider extends ChangeNotifier {
  late String _errorMessage;
  String get errorMessage => _errorMessage;

  int _page = 1;
  int _pageSize = 5;

  SportsState _sportsState = SportsState.inital;
  SportsState get sportState => _sportsState;

  List<NewsArticles> _sportsArticles = [];
  List<NewsArticles> get sportsArticlesList => _sportsArticles;

  Future<List<NewsArticles>> getArticles(
      {required String category, required bool isRefreshed}) async {
    try {
      _sportsState = SportsState.loading;
      await Future.delayed(const Duration(seconds: 2));

      List<NewsArticles> newsData = await ApiServices().getNewsResponse(
          page: _page, pageSize: _pageSize, category: category);

      if (!isRefreshed) {
        _sportsArticles = newsData;
        notifyListeners();
        _sportsState = SportsState.loaded;
      } else {
        if (_pageSize <= 100) {
          _pageSize = _pageSize += 10;
          _sportsArticles.addAll(newsData);

          _sportsState = SportsState.loaded;

          if (_pageSize == 100) {
            _pageSize = 20;
            // _sportsArticles!.addAll(newsData);
            _sportsArticles = newsData;
            _sportsState = SportsState.loaded;
          }
        }
      }
    } catch (e) {
      Logger().d(e.toString());
      _errorMessage = e.toString();
      _sportsState = SportsState.error;
    }
    notifyListeners();

    return _sportsArticles;
  }
}
