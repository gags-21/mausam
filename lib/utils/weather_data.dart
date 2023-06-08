class WeatherData {
  WeatherData({
    required this.cityName,
    required this.weatherInfo,
  });

  String cityName;
  List<WeatherInfo> weatherInfo;

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
        cityName: json["city"]["name"],
        weatherInfo: List<WeatherInfo>.from(
          json["list"].map((element) => WeatherInfo.fromJson(element)),
        ),
      );
}

class WeatherInfo {
  WeatherInfo({
    required this.date,
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.weatherType,
    required this.windSpeed,
  });

  DateTime date;
  double temp;
  double feelsLike;
  double humidity;
  String weatherType;
  double windSpeed;

  factory WeatherInfo.fromJson(Map<String, dynamic> json) => WeatherInfo(
        date: DateTime.parse(json["dt_txt"]),
        temp: json["main"]["temp"],
        feelsLike: json["main"]["feels_like"],
        humidity: json["main"]["humidity"],
        weatherType: json["weather"][0]["description"],
        windSpeed: json["wind"]["speed"],
      );
}
