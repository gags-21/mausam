import 'package:flutter/material.dart';
import 'package:weather_app/services/api.dart';
import 'package:weather_app/utils/weather_data.dart';

class WeatherProvider extends ChangeNotifier {
  final weatherApi = WeatherDataApi();

  bool _isLoading = false;

  String _city = "";
  List<ListElement> _listOfWeatherInfo = [];
  String _errorMessage = "";

  bool get isLoading => _isLoading;
  String get city => _city;
  List<ListElement> get listOfWeatherInfo => _listOfWeatherInfo;
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
      _city = value.city.name;
      _listOfWeatherInfo = value.list;
      notifyListeners();
    }).catchError((error) {
      _isLoading = false;
      _errorMessage = error.toString();
      notifyListeners();
      throw (error);
    });
  }
}
