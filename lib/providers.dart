import 'package:flutter/material.dart';

class ThemeModeChanger extends ChangeNotifier {
  ThemeMode _themeMode;
  ThemeModeChanger(this._themeMode);

  get getThemeMode => _themeMode;
  void setThemeMode(ThemeMode themeMode) {
    _themeMode= themeMode;
    notifyListeners();
  }
}

class LanguageChanger extends ChangeNotifier {
  Locale _locale;
  LanguageChanger(this._locale);

  get getLocale => _locale;
  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}