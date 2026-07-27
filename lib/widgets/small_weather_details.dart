import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:weather/core/extensions/l10n_extensions.dart';
import 'package:weather/models/advanced_weather_model.dart';

class SmallWeatherDetails extends StatelessWidget {
  final WeatherAdvanced weatherAdvanced;
  const SmallWeatherDetails({super.key, required this.weatherAdvanced});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
          bottom: 10,
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Color.fromARGB(20, 255, 255, 255),
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 0,
            children: [
              Text(
                '${context.l10n.rightNowIn} ${weatherAdvanced.location.name}, ${weatherAdvanced.location.region}',
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 190,
                    child: AutoSizeText(
                      '${weatherAdvanced.current.tempC}°',
                      style: TextStyle(fontSize: 96),
                      maxLines: 1,
                    ),
                  ),
                  Image.network(
                    weatherAdvanced.current.condition.icon,
                    scale: 0.75,
                    alignment: AlignmentGeometry.topRight,
                  ),
                ],
              ),
              Text('${context.l10n.feelsLike} ${weatherAdvanced.current.feelslikeC}°'),
              SizedBox(height: 10, width: double.infinity),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.5,
                padding: EdgeInsets.zero,
                children: [
                  _buildDetailTile(
                    Icons.water_drop,
                    context.l10n.humidity,
                    '${weatherAdvanced.current.humidity}%',
                  ),
                  _buildDetailTile(
                    Icons.wind_power,
                    context.l10n.wind,
                    '${weatherAdvanced.current.windKph} ${context.l10n.mb}',
                  ),
                  _buildDetailTile(
                    Icons.compress,
                    context.l10n.pressure,
                    '${weatherAdvanced.current.pressureMb} ${context.l10n.mb}',
                  ),
                  _buildDetailTile(
                    Icons.umbrella,
                    context.l10n.precip,
                    '${weatherAdvanced.current.precipMm} ${context.l10n.mm}',
                  ),
                ],
              ),
              SizedBox(height: 10, width: double.infinity),
              Text('${context.l10n.windGusts} ${weatherAdvanced.current.gustKph} ${context.l10n.mb}'),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildDetailTile(IconData icon, String label, String value) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color.fromARGB(20, 255, 255, 255),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      children: [
        Icon(icon, color: Colors.grey, size: 20),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    ),
  );
}
