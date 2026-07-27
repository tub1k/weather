import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static late SharedPreferences _prefs;

  // Инициализация при запуске
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Метод для сохранения городов
  static Future<void> saveFavorites(List<String> cities) async {
    await _prefs.setStringList('favorite_cities', cities);
  }

  // Метод для загрузки городов
  static List<String> getFavorites() {
    return _prefs.getStringList('favorite_cities') ?? [];
  }

  static String getLocale() {
    return _prefs.getString('locale') ?? 'system'; // if we recieve this keyword, we use PlatformDispatcher.instance.locale
  }

  static Future<void> saveLocale(String localeString) async {
    await _prefs.setString('locale', localeString);
  }
}