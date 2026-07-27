import 'package:flutter/material.dart';
import 'package:weather/core/extensions/l10n_extensions.dart';
import 'package:weather/l10n/app_localizations.dart';
import 'package:weather/models/weather_data.dart';
import 'package:weather/services/get_weather_service.dart';
import 'package:weather/services/prefs_service.dart';
import 'package:weather/widgets/add_city_widget.dart';
import 'package:weather/widgets/bottom_navigation_bar.dart';
import 'package:weather/widgets/small_weather_widget.dart';

class SavedCityList extends StatefulWidget {
  const SavedCityList({super.key});
  @override
  State<SavedCityList> createState() => _SavedCityListState();
}

class _SavedCityListState extends State<SavedCityList> {
  late Future<List<Weather>> _weatherFuture;
  late List<Weather> favoriteCitiesWeather;

  @override
  void initState() {
    super.initState();
    _weatherFuture = loadAllWeather();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      favoriteCitiesWeather = [];
      _weatherFuture = loadAllWeather();
    });
  }

  Future<void> _deleteCity(Weather city) async {
    List<String> newList = PrefsService.getFavorites();
    newList.remove(city.technicalName);
    PrefsService.saveFavorites(newList);
    setState(() {
      favoriteCitiesWeather.remove(city);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _weatherFuture,
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.black,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        favoriteCitiesWeather =
            asyncSnapshot.data ??
            [
              Weather(
                cityName: context.l10n.loading,
                temp_c: 0,
                technicalName: '',
                imagelink: '',
              ),
            ];

        return Scaffold(
          bottomNavigationBar: MainNavigationBar(
            key: Key('MainNavigationBar'),
            currentIndex: 0,
            onReturn: _handleRefresh,
          ),
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!.favouriteCities,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.black,
            scrolledUnderElevation: 0,
          ),
          body: RefreshIndicator(
            onRefresh: _handleRefresh,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: favoriteCitiesWeather.length + 1,
              itemBuilder: (context, index) {
                if (index == favoriteCitiesWeather.length) {
                  return AddCityWidget(onReturn: _handleRefresh);
                }
                final city = favoriteCitiesWeather[index];
                return Dismissible(
                  key: Key(city.cityName),

                  direction: DismissDirection.endToStart,

                  background: Container(color: Colors.transparent),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),

                  onDismissed: (direction) {
                    _deleteCity(city);
                  },

                  child: SmallWeatherWidget(
                    weather: city,
                    onPressed: _handleRefresh,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

Future<List<Weather>> loadAllWeather() async {
  final weatherService = WeatherService();
  List<String> cities = PrefsService.getFavorites();
  final futures = cities
      .map((city) => weatherService.fetchCurrentWeather(city))
      .toList();

  try {
    final results = await Future.wait(futures);
    return results;
  } catch (e) {
    print('e');
    return [];
  }
}
