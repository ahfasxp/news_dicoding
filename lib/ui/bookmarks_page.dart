import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_dicoding/provider/database_provider.dart';
import 'package:news_app_dicoding/utils/result_state.dart';
import 'package:news_app_dicoding/widgets/card_article.dart';
import 'package:news_app_dicoding/widgets/platform_widget.dart';
import 'package:provider/provider.dart';

class BookmarksPage extends StatelessWidget {
  static const String bookmarksTitle = 'Bookmarks';
  const BookmarksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bookmarksTitle),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(bookmarksTitle),
          transitionBetweenRoutes: false,
        ),
        child: _buildList(context));
  }

  Widget _buildList(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, _) {
      if (provider.state == ResultState.HasData) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: provider.bookmarks.length,
          itemBuilder: (context, index) {
            var article = provider.bookmarks[index];
            return CardArticle(
              article: article,
            );
          },
        );
      } else {
        return Center(
          child: Text(provider.message),
        );
      }
    });
  }
}
