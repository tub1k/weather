import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/models/advanced_weather_model.dart';
import 'package:weather/models/city_suggestion.dart';
import 'package:weather/models/weather_data.dart';

const apiKey = String.fromEnvironment('WEATHER_API_KEY');

class WeatherService {
  final String _baseUrl = 'https://api.weatherapi.com/v1';

  Future<Weather> fetchCurrentWeather(String city) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/current.json?key=$apiKey&q=$city&aqi=no'),
    );

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body), city);
    } else {
      // Хорошая практика: выбрасывать понятную ошибку
      throw Exception('Ошибка API: ${response.statusCode}');
    }
  }

  Future<List<CitySuggestion>> getSuggestions(String query) async {
    if (query.isEmpty) return [];

    final url =
        'https://api.weatherapi.com/v1/search.json?key=$apiKey&q=$query';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.map((json) => CitySuggestion.fromJson(json)).toList();
      } else {
        print('Ошибка поиска: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Ошибка сети: $e');
      return [];
    }
  }

  Future<WeatherAdvanced> fetchWeatherAdvanced(String query) async {
    final url =
        'https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$query&days=3&aqi=no&alerts=no&lang=ru';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final WeatherAdvanced data = weatherAdvancedFromJson(response.body);
        return data;
      } else {
        print('Ошибка поиска: ${response.statusCode}');
        return weatherAdvancedFromJson('');
      }
    } catch (e) {
      print('Ошибка сети: $e');
      return weatherAdvancedFromJson('');
    }
  }
}
