// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get favouriteCities => 'Favorite Cities';

  @override
  String get rightNowIn => 'Right now in';

  @override
  String get language => 'Language';

  @override
  String get systemLang => 'System language';

  @override
  String get clearFavorites => 'Clear favorites';

  @override
  String get clearFavoritesDesc =>
      'This will delete ALL cities from favorite list';

  @override
  String get clearFavoritesConfirm =>
      'Are you sure you want to delete ALL favorites?';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get settings => 'Settings';

  @override
  String get search => 'Search';

  @override
  String get searchTip => 'Enter city name...';

  @override
  String get feelsLike => 'Feels like';

  @override
  String get humidity => 'Humidity';

  @override
  String get wind => 'Wind';

  @override
  String get pressure => 'Pressure';

  @override
  String get precip => 'Precip';

  @override
  String get windGusts => 'Wind gusts up to';

  @override
  String get kmh => 'Km/h';

  @override
  String get today => 'Today';

  @override
  String get tomorrow => 'Tomorrow';

  @override
  String get dayAfterTomorrow => 'Day after tomorrow';

  @override
  String get forecastInDetails => 'Forecast';

  @override
  String get addedFavorite => 'Added to Favorites';

  @override
  String get removedFavorite => 'Removed from Favorites';

  @override
  String get mm => 'mm';

  @override
  String get mb => 'mb';

  @override
  String get loading => 'Loading';
}
