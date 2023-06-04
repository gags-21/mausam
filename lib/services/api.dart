import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/utils/weather_data.dart';

class WeatherDataApi {
  // getting weather info from api
  Future<void> getWeatherData({
    String? city,
    String? zipCode,
  }) async {
    const key = "Key here";
    final url =
        "https://api.openweathermap.org/data/2.5/forecast?q=400028&appid=$key";

    final response =
        await http.get(Uri.parse(url)); // getting response from api

    if (response.statusCode == 200) {
      var weatherInfo = WeatherData.fromJson(jsonDecode(response.body));
    } else {
      print("Error: ${response.reasonPhrase}");
    }
    throw Exception("Error: ${response.reasonPhrase}");
  }
}
