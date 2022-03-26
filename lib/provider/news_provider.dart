import 'package:flutter/foundation.dart';
import 'package:news_dicoding/data/api/api_service.dart';
import 'package:news_dicoding/data/model/article.dart';
import 'package:news_dicoding/utils/result_state.dart';

class NewsProvider extends ChangeNotifier {
  final ApiService apiService;
  late ArticlesResult _articlesResult;
  late ResultState _state;
  String _message = '';

  NewsProvider({required this.apiService}) {
    fetchAllArticle();
  }

  String get message => _message;
  ArticlesResult get result => _articlesResult;
  ResultState get state => _state;

  Future<dynamic> fetchAllArticle() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final article = await apiService.topHeadlines();
      if (article.articles.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _articlesResult = article;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
