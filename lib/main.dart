import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/providers/locale_provider.dart';
import 'package:weather/l10n/app_localizations.dart';
import 'package:weather/models/weather_data.dart';
import 'package:weather/services/prefs_service.dart';
import 'package:weather/screens/saved_city_list.dart';
import 'package:weather/screens/search_screen.dart';
import 'package:weather/screens/settings_screen.dart';
import 'constants/routes.dart';

List<Weather> weatherResults = [];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsService.init();
  //PrefsService.saveFavorites(['bekovo-penza-russia']);
  runApp(ChangeNotifierProvider(create: (context) => LocaleProvider(), child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    final localeProvider = context.watch<LocaleProvider>();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'roboto',
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.dark(),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 30,
          ),
          bodyLarge: TextStyle(
            fontSize: 20
          )
        ),
      ),
      home: const SavedCityList(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      key: ValueKey(localeProvider.locale.languageCode),
      locale: localeProvider.locale,
      routes: {
        searchRoute: (context) => SearchScreen(),
        settingsRoute: (context) => SettingsScreen(),
      },
    );
  }
}


