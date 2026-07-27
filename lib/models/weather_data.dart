class Weather {
  final String cityName;
  final double temp_c;
  final String technicalName;
  final String imagelink;

  Weather({
    required this.cityName,
    required this.temp_c,
    required this.technicalName,
    required this.imagelink,
  });

  factory Weather.fromJson(Map<String, dynamic> json, String technicalName) {
    return Weather(
      cityName: json['location']['name'],
      temp_c: json['current']['temp_c'].toDouble(), 
      technicalName: technicalName,
      imagelink: 'https:${json['current']['condition']['icon']}',
    );
  }
}

