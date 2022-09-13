import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:news_app/src/models/news_articles/news_articles.dart';
import 'package:news_app/src/services/api_services.dart';




enum TechnologyState { inital, loading, loaded, error }

class NewsProvider with ChangeNotifier {
  late ApiServices services;
  bool loading = false;

  

 

  TechnologyState _technologyState = TechnologyState.inital;
  TechnologyState get technologyState => _technologyState;

  late String _errorMessage;
  String get errorMessage => _errorMessage;

  int _page = 1;
  int _pageSize = 5;

  get isLoading => loading;

  List<NewsArticles>? _articles = [];
  List<NewsArticles>? get articels => _articles;

  Future<List<NewsArticles>> getArticles(
      {required String category, required bool isRefreshed}) async {
    try {
      _technologyState = TechnologyState.loading;
      await Future.delayed(const Duration(seconds: 2));

      List<NewsArticles> newsData = await ApiServices().getNewsResponse(
          page: _page, pageSize: _pageSize, category: category);

      if (!isRefreshed) {
        _articles = newsData;
        notifyListeners();
        _technologyState = TechnologyState.loaded;
      } else {
        if (_pageSize <= 100) {
          _pageSize = _pageSize += 10;
          _articles!.addAll(newsData);

          _technologyState = TechnologyState.loaded;

          if (_pageSize == 100) {
            _pageSize = 20;
            // _articles!.addAll(newsData);
            _articles = newsData;
            _technologyState = TechnologyState.loaded;
          }
        }
      }
    } catch (e) {
      Logger().d(e.toString());
      _errorMessage = e.toString();
      _technologyState = TechnologyState.error;
    }
    notifyListeners();

    return _articles!;
  }
}
