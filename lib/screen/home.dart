import 'package:flutter/material.dart';
import 'package:weather_app/services/api.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Provide location"),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  WeatherDataApi().getWeatherData();
                },
                child: const Text("Search"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
