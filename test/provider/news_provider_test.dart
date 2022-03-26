import 'package:flutter_test/flutter_test.dart';
import 'package:news_dicoding/data/api/api_service.dart';
import 'package:news_dicoding/provider/news_provider.dart';

void main() {
  test('must contain a list of articles', () async {
    // arrange
    var newsProvider = NewsProvider(apiService: ApiService());
    // act
    await newsProvider.fetchAllArticle();
    // assert
    var result = newsProvider.result.articles;
    expect(result.length, greaterThan(0));
  });
}
