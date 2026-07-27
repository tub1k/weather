// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get favouriteCities => 'Любимые Города';

  @override
  String get rightNowIn => 'Сейчас в';

  @override
  String get language => 'Язык';

  @override
  String get systemLang => 'Язык системы';

  @override
  String get clearFavorites => 'Очистить Любимые';

  @override
  String get clearFavoritesDesc => 'Это удалит ВСЕ города из списка любимых';

  @override
  String get clearFavoritesConfirm =>
      'Вы уверены, что хотите удалить ВСЕ города из списка?';

  @override
  String get cancel => 'Отмена';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get settings => 'Настройки';

  @override
  String get search => 'Поиск';

  @override
  String get searchTip => 'Введите название города...';

  @override
  String get feelsLike => 'Ощущается как';

  @override
  String get humidity => 'Влажность';

  @override
  String get wind => 'Ветер';

  @override
  String get pressure => 'Давление';

  @override
  String get precip => 'Осадки';

  @override
  String get windGusts => 'Порывы ветра до';

  @override
  String get kmh => 'км/ч';

  @override
  String get today => 'Сегодня';

  @override
  String get tomorrow => 'Завтра';

  @override
  String get dayAfterTomorrow => 'Послезавтра';

  @override
  String get forecastInDetails => '';

  @override
  String get addedFavorite => 'Добавлен в любимые';

  @override
  String get removedFavorite => 'Убран из любимых';

  @override
  String get mm => 'мм';

  @override
  String get mb => 'мб';

  @override
  String get loading => 'Загрузка';
}
