import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:news_dicoding/common/navigation.dart';
import 'package:news_dicoding/data/api/api_service.dart';
import 'package:news_dicoding/data/db/database_helper.dart';
import 'package:news_dicoding/data/model/article.dart';
import 'package:news_dicoding/data/preferences/preferences_helper.dart';
import 'package:news_dicoding/provider/database_provider.dart';
import 'package:news_dicoding/provider/news_provider.dart';
import 'package:news_dicoding/provider/preferences_provider.dart';
import 'package:news_dicoding/provider/scheduling_provider.dart';
import 'package:news_dicoding/ui/home_page.dart';
import 'package:news_dicoding/utils/background_service.dart';
import 'package:news_dicoding/utils/notification_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ui/article_detail_page.dart';
import 'ui/article_web_view.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NewsProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
      ],
      child: Consumer<PreferencesProvider>(builder: (context, provider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'News App',
          navigatorKey: navigatorKey,
          theme: provider.themeData,
          // bulder for Cupertino Theme Ios
          builder: (context, child) {
            return CupertinoTheme(
              data: CupertinoThemeData(
                brightness:
                    provider.isDarkTheme ? Brightness.dark : Brightness.light,
              ),
              child: Material(
                child: child,
              ),
            );
          },
          initialRoute: HomePage.routeName,
          routes: {
            HomePage.routeName: (context) => HomePage(),
            ArticleDetailPage.routeName: (context) => ArticleDetailPage(
                  article:
                      ModalRoute.of(context)?.settings.arguments as Article,
                ),
            ArticleWebView.routeName: (context) => ArticleWebView(
                  url: ModalRoute.of(context)?.settings.arguments as String,
                ),
          },
        );
      }),
    );
  }
}
