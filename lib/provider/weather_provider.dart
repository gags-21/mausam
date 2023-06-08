import 'package:flutter/material.dart';
import 'package:weather_app/services/api.dart';
import 'package:weather_app/utils/weather_data.dart';

class WeatherProvider extends ChangeNotifier {
  final weatherApi = WeatherDataApi();

  bool _isLoading = false;

  String _city = "";
  List<WeatherInfo> _listOfWeatherInfo = [];
  String _errorMessage = "";

  bool get isLoading => _isLoading;
  String get city => _city;
  List<WeatherInfo> get listOfWeatherInfo => _listOfWeatherInfo;
  String get errorMsg => _errorMessage;

  Future<void> setWeatherDetails({
    required String cityOriZipCode,
  }) async {
    _isLoading = true;
    notifyListeners();

    // fetching data
    await weatherApi
        .getWeatherData(cityOrZipCode: cityOriZipCode)
        .then((value) {
      _isLoading = false;
      _city = value.cityName;
      _listOfWeatherInfo = value.weatherInfo;
      notifyListeners();
    }).catchError((error) {
      _isLoading = false;
      _errorMessage = error.toString();
      notifyListeners();
      throw (error);
    });
  }
}
