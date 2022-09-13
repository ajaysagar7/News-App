import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

import '../../models/news_articles/news_articles.dart';
import '../../services/api_services.dart';

enum ScienceState { inital, loading, loaded, error }

class ScienceProvider extends ChangeNotifier {
  late String _errorMessage;
  String get errorMessage => _errorMessage;

  int _page = 1;
  int _pageSize = 5;

  ScienceState _scienceState = ScienceState.inital;
  ScienceState get scienceState => _scienceState;

  List<NewsArticles> _scienceArticelsList = [];
  List<NewsArticles> get scienceArticlesList => _scienceArticelsList;

  Future<List<NewsArticles>> getScienceArticels(
      {required String category, required bool isRefreshed}) async {
    try {
      _scienceState = ScienceState.loading;
      await Future.delayed(const Duration(seconds: 2));

      List<NewsArticles> newsData = await ApiServices().getNewsResponse(
          page: _page, pageSize: _pageSize, category: category);

      if (!isRefreshed) {
        _scienceArticelsList = newsData;
        notifyListeners();
        _scienceState = ScienceState.loaded;
      } else {
        if (_pageSize <= 100) {
          _pageSize = _pageSize += 10;
          _scienceArticelsList.addAll(newsData);

          _scienceState = ScienceState.loaded;

          if (_pageSize == 100) {
            _pageSize = 20;
            // _scienceArticelsList!.addAll(newsData);
            _scienceArticelsList = newsData;
            _scienceState = ScienceState.loaded;
          }
        }
      }
    } catch (e) {
      Logger().d(e.toString());
      _errorMessage = e.toString();
      _scienceState = ScienceState.error;
    }
    notifyListeners();

    return _scienceArticelsList;
  }
}
