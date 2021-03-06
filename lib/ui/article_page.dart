import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_dicoding/provider/news_provider.dart';
import 'package:news_dicoding/utils/result_state.dart';
import 'package:news_dicoding/widgets/card_article.dart';
import 'package:news_dicoding/widgets/platform_widget.dart';
import 'package:provider/provider.dart';

class ArticlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('News'),
          transitionBetweenRoutes: false,
        ),
        child: _buildList(context));
  }

  Widget _buildList(BuildContext context) {
    return Consumer<NewsProvider>(builder: (context, state, _) {
      if (state.state == ResultState.Loading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state.state == ResultState.HasData) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: state.result.articles.length,
          itemBuilder: (context, index) {
            var article = state.result.articles[index];
            return CardArticle(
              article: article,
            );
          },
        );
      } else if (state.state == ResultState.NoData) {
        return Center(child: Text(state.message));
      } else if (state.state == ResultState.Error) {
        return Center(child: Text(state.message));
      } else {
        return Center(child: Text(''));
      }
    });
  }
}
