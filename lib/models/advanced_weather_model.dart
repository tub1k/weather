import 'dart:convert';

WeatherAdvanced weatherAdvancedFromJson(String str) => WeatherAdvanced.fromJson(json.decode(str));

String weatherAdvancedToJson(WeatherAdvanced data) => json.encode(data.toJson());

class WeatherAdvanced {
    Location location;
    Current current;
    Forecast forecast;

    WeatherAdvanced({
        required this.location,
        required this.current,
        required this.forecast,
    });

    factory WeatherAdvanced.fromJson(Map<String, dynamic> json) => WeatherAdvanced(
        location: Location.fromJson(json["location"]),
        current: Current.fromJson(json["current"]),
        forecast: Forecast.fromJson(json["forecast"]),
    );

    Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "current": current.toJson(),
        "forecast": forecast.toJson(),
    };
}

class Current {
    double? tempC;
    double? tempF;
    Condition condition;
    double? windMph;
    double? windKph;
    double? pressureMb;
    double? precipMm;
    int? humidity;
    double? feelslikeC;
    double? feelslikeF;
    double? gustMph;
    double? gustKph;
    String time;
    double? pressureIn;

    Current({
        this.tempC,
        this.tempF,
        required this.condition,
        this.windMph,
        this.windKph,
        this.pressureMb,
        this.precipMm,
        this.humidity,
        this.feelslikeC,
        this.feelslikeF,
        this.gustMph,
        this.gustKph,
        required this.time,
        this.pressureIn,
    });

    factory Current.fromJson(Map<String, dynamic> json) => Current(
        tempC: json["temp_c"]?.toDouble(),
        tempF: json["temp_f"]?.toDouble(),
        condition: Condition.fromJson(json["condition"]),
        windMph: json["wind_mph"]?.toDouble(),
        windKph: json["wind_kph"]?.toDouble(),
        pressureMb: json["pressure_mb"]?.toDouble(),
        precipMm: json["precip_mm"]?.toDouble(),
        humidity: json["humidity"],
        feelslikeC: json["feelslike_c"]?.toDouble(),
        feelslikeF: json["feelslike_f"]?.toDouble(),
        gustMph: json["gust_mph"]?.toDouble(),
        gustKph: json["gust_kph"]?.toDouble(),
        time: json["time"] ?? json["last_updated"] ?? "",
        pressureIn: json["pressure_in"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "temp_c": tempC,
        "temp_f": tempF,
        "condition": condition.toJson(),
        "wind_mph": windMph,
        "wind_kph": windKph,
        "pressure_mb": pressureMb,
        "precip_mm": precipMm,
        "humidity": humidity,
        "feelslike_c": feelslikeC,
        "feelslike_f": feelslikeF,
        "gust_mph": gustMph,
        "gust_kph": gustKph,
        "time": time,
        "pressure_in": pressureIn,
    };
}

class Condition {
    String icon;

    Condition({
        required this.icon,
    });

    factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        icon: 'https:${json["icon"]}',
    );

    Map<String, dynamic> toJson() => {
        "icon": icon,
    };
}

class Forecast {
    List<Forecastday> forecastday;

    Forecast({
        required this.forecastday,
    });

    factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
        forecastday: List<Forecastday>.from(json["forecastday"].map((x) => Forecastday.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "forecastday": List<dynamic>.from(forecastday.map((x) => x.toJson())),
    };
}

class Forecastday {
    DateTime date;
    int dateEpoch;
    Day day;
    Astro astro;
    List<Current> hour;

    Forecastday({
        required this.date,
        required this.dateEpoch,
        required this.day,
        required this.astro,
        required this.hour,
    });

    factory Forecastday.fromJson(Map<String, dynamic> json) => Forecastday(
        date: DateTime.parse(json["date"]),
        dateEpoch: json["date_epoch"],
        day: Day.fromJson(json["day"]),
        astro: Astro.fromJson(json["astro"]),
        hour: List<Current>.from(json["hour"].map((x) => Current.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "date_epoch": dateEpoch,
        "day": day.toJson(),
        "astro": astro.toJson(),
        "hour": List<dynamic>.from(hour.map((x) => x.toJson())),
    };
}

class Astro {
    String sunrise;
    String sunset;

    Astro({
        required this.sunrise,
        required this.sunset,
    });

    factory Astro.fromJson(Map<String, dynamic> json) => Astro(
        sunrise: json["sunrise"],
        sunset: json["sunset"],
    );

    Map<String, dynamic> toJson() => {
        "sunrise": sunrise,
        "sunset": sunset,
    };
}

class Day {
    double maxtempC;
    double maxtempF;
    double mintempC;
    double mintempF;
    double avgtempC;
    double avgtempF;
    double maxwindKph;
    double maxwindMph;
    double totalprecipMm;
    int avghumidity;
    Condition condition;

    Day({
        required this.maxtempC,
        required this.maxtempF,
        required this.mintempC,
        required this.mintempF,
        required this.avgtempC,
        required this.avgtempF,
        required this.maxwindKph,
        required this.maxwindMph,
        required this.totalprecipMm,
        required this.avghumidity,
        required this.condition,
    });

    factory Day.fromJson(Map<String, dynamic> json) => Day(
        maxtempC: json["maxtemp_c"]?.toDouble(),
        maxtempF: json["maxtemp_f"]?.toDouble(),
        mintempC: json["mintemp_c"]?.toDouble(),
        mintempF: json["mintemp_f"]?.toDouble(),
        avgtempC: json["avgtemp_c"]?.toDouble(),
        avgtempF: json["avgtemp_f"]?.toDouble(),
        maxwindKph: json["maxwind_kph"]?.toDouble(),
        maxwindMph: json["maxwind_mph"]?.toDouble(),
        totalprecipMm: json["totalprecip_mm"]?.toDouble(),
        avghumidity: json["avghumidity"],
        condition: Condition.fromJson(json["condition"]),
    );

    Map<String, dynamic> toJson() => {
        "maxtemp_c": maxtempC,
        "maxtemp_f": maxtempF,
        "mintemp_c": mintempC,
        "mintemp_f": mintempF,
        "avgtemp_c": avgtempC,
        "avgtemp_f": avgtempF,
        "maxwind_kph": maxwindKph,
        "maxwind_mph": maxwindMph,
        "totalprecip_mm": totalprecipMm,
        "avghumidity": avghumidity,
        "condition": condition.toJson(),
    };
}

class Location {
    String name;
    String region;
    String country;
    double lat;
    double lon;
    String tzId;
    int localtimeEpoch;
    String localtime;

    Location({
        required this.name,
        required this.region,
        required this.country,
        required this.lat,
        required this.lon,
        required this.tzId,
        required this.localtimeEpoch,
        required this.localtime,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        region: json["region"],
        country: json["country"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        tzId: json["tz_id"],
        localtimeEpoch: json["localtime_epoch"],
        localtime: json["localtime"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "region": region,
        "country": country,
        "lat": lat,
        "lon": lon,
        "tz_id": tzId,
        "localtime_epoch": localtimeEpoch,
        "localtime": localtime,
    };
}
