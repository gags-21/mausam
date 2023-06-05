import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/utils/api_key.dart';

class WeatherDataApi {
  // getting weather info from api
  Future<Map> getWeatherData({
    required String cityOrZipCode,
  }) async {
    // key
    const key = weatherApiKey;

    // check if city & zip both are not empty
    if (cityOrZipCode != "") {
      final url =
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityOrZipCode&appid=$key&units=metric";

      final response =
          await http.get(Uri.parse(url)); // getting response from api

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      }
      throw ("${response.reasonPhrase}");
    } else {
      throw ("Please enter a valid city or zip code");
    }
  }
}
