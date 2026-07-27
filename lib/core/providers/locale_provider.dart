import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather/services/prefs_service.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = PlatformDispatcher.instance.locale;

  LocaleProvider() {
    _initLocale();
  }

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (_locale == locale) return;

    _locale = locale;
    notifyListeners();
  }

  void _initLocale() {
    final savedLocale = PrefsService.getLocale();
    if (savedLocale != 'system' && savedLocale.isNotEmpty) {
      _locale = Locale(savedLocale);
    } else {
      _locale = PlatformDispatcher.instance.locale;
    }
  }

  void clearLocale() {
    _locale = const Locale('ru');
    notifyListeners();
  }
}