import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:weather/core/extensions/l10n_extensions.dart';
import 'package:weather/models/weather_data.dart';
import 'package:weather/screens/detailed_city_info.dart';

class SmallWeatherWidget extends StatelessWidget {
  final Weather weather;
  final VoidCallback? onPressed;
  const SmallWeatherWidget({super.key, required this.weather, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Stack(
        children: [Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Color.fromARGB(255, 20, 20, 20),
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 0,
            children: [
              Text('${context.l10n.rightNowIn} ${weather.cityName}', style: TextStyle(fontSize: 20),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 190,
                    child: AutoSizeText(
                      '${weather.temp_c}°',
                      style: TextStyle(fontSize: 96),
                      maxLines: 1,
                    ),),
                  Image.network(
                    weather.imagelink,
                    scale: 0.75,
                    alignment: AlignmentGeometry.topRight,
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned.fill(
            child: Material(
              borderRadius: BorderRadius.circular(32),
              color: Colors.transparent,
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () async {
                  await Navigator.push(context, MaterialPageRoute(builder: (context) => DetailedCityInfo(showName: weather.cityName, technicalName: weather.technicalName, bgTemp: weather.temp_c,)));
                  await Future.delayed(const Duration(milliseconds: 100));
                  onPressed?.call();
                },
              ),
            ),
          ),])
      ),
    );
  }
}
