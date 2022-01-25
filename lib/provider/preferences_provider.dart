import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_dicoding/common/style.dart';
import 'package:news_dicoding/data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getTheme();
    _getDailyNewsPreferences();
  }

  // Preferences for Theme
  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  void _getTheme() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  void enableDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getTheme();
  }

  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

  // Preferences for Daily News
  bool _isDailyNewsActive = false;
  bool get isDailyNewsActive => _isDailyNewsActive;

  void _getDailyNewsPreferences() async {
    _isDailyNewsActive = await preferencesHelper.isDailyNewsActive;
    notifyListeners();
  }

  void enableDailyNews(bool value) {
    preferencesHelper.setDailyNews(value);
    _getDailyNewsPreferences();
  }
}
