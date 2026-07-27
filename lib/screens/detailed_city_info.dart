import 'package:flutter/material.dart';
import 'package:weather/constants/weather_gradient.dart';
import 'package:weather/core/extensions/l10n_extensions.dart';
import 'package:weather/models/advanced_weather_model.dart';
import 'package:weather/services/get_weather_service.dart';
import 'package:weather/services/prefs_service.dart';
import 'package:weather/widgets/small_weather_details.dart';

class DetailedCityInfo extends StatefulWidget {
  final String technicalName;
  final String showName;
  final double? bgTemp;
  const DetailedCityInfo({
    super.key,
    required this.technicalName,
    required this.showName,
    this.bgTemp,
  });

  @override
  State<DetailedCityInfo> createState() => _DetailedCityInfoState();
}

class _DetailedCityInfoState extends State<DetailedCityInfo> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  void _checkIfFavorite() {
    List<String> favorites = PrefsService.getFavorites();
    setState(() {
      isFavorite = favorites.contains(widget.technicalName);
    });
  }

  void _toggleFavorite() async {
    List<String> favorites = PrefsService.getFavorites();
    String cityName = widget.technicalName;

    setState(() {
      if (isFavorite) {
        favorites.remove(cityName);
        isFavorite = false;
      } else {
        favorites.add(cityName);
        isFavorite = true;
      }
    });

    await PrefsService.saveFavorites(favorites);

    if (mounted) {ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isFavorite ? context.l10n.addedFavorite : context.l10n.removedFavorite),
        duration: const Duration(seconds: 1),
      ),
    );}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(129, 0, 0, 0),
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
        title: Text(widget.showName, style: TextStyle(color: Colors.white)),
      ),
      body: FutureBuilder(
        future: WeatherService().fetchWeatherAdvanced(widget.technicalName),
        builder: (context, asyncSnapshot) {
          final weatherAdvanced = asyncSnapshot.data;
          if (weatherAdvanced != null) {
            return Container(
              decoration: BoxDecoration(
                gradient: getWeatherGradient(
                  widget.bgTemp ?? weatherAdvanced.current.tempC ?? 20,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 110),
                    SmallWeatherDetails(weatherAdvanced: weatherAdvanced),
                    _detailedDayForecast(weatherAdvanced, context.l10n.today, 0, context),
                    _detailedDayForecast(weatherAdvanced, context.l10n.tomorrow, 1, context),
                    _detailedDayForecast(
                      weatherAdvanced,
                      context.l10n.dayAfterTomorrow,
                      2, context
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            );
          } else {
            return Container(
              color: Colors.black,
              child: const Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}

Widget _detailedDayForecast(WeatherAdvanced w, String dayName, int dayIndex, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.all(16.0),
        child: Text("$dayName ${context.l10n.forecastInDetails}", style: TextStyle(fontSize: 20)),
      ),
      SizedBox(
        height: 180,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 24,
          itemBuilder: (context, index) {
            return _buildHourItem(w.forecast.forecastday[dayIndex].hour[index]);
          },
        ),
      ),
    ],
  );
}

Widget _buildHourItem(Current hour) {
  return Container(
    width: 80,
    padding: const EdgeInsets.all(8),
    child: Column(
      children: [
        Text(hour.time.substring(hour.time.length - 5)),
        Image.network(hour.condition.icon, width: 40),
        Text('${hour.tempC}°', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        _miniDetail(Icons.water_drop, '${hour.humidity}%'),
        _miniDetail(Icons.air, '${hour.windKph}'),
      ],
    ),
  );
}

Widget _miniDetail(IconData icon, String text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon, size: 12, color: Colors.grey),
      Text(text, style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}
