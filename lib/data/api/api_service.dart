import 'dart:convert';

import 'package:news_app_dicoding/data/model/article.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String _baseUrl = 'https://newsapi.org/v2/';
  static final String _apiKey = '678bfd25b40d4233966be3959d858427';
  static final String _category = 'business';
  static final String _country = 'id';

  Future<ArticlesResult> topHeadlines() async {
    final response = await http.get(Uri.parse(_baseUrl +
        "top-headlines?country=$_country&category=$_category&apiKey=$_apiKey"));

    if (response.statusCode == 200) {
      return ArticlesResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
