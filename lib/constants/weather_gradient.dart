import 'package:flutter/material.dart';

LinearGradient getWeatherGradient(double temp) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [HSVColor.fromAHSV(1, (160-temp*4).clamp(0, 240), 0.7, 0.35).toColor(), HSVColor.fromAHSV(1, (160-temp*4).clamp(0, 240)+15, 0.7, 0.35).toColor()],
    );
}