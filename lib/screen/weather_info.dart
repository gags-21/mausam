import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';

class WeatherInfoScreen extends StatelessWidget {
  const WeatherInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Weather Info"),
            const SizedBox(
              height: 50,
            ),
            Consumer<WeatherProvider>(
              builder: (context, weatherProvider, _) {
                final weatherInfoCount =
                    weatherProvider.listOfWeatherInfo.length;
                if (weatherProvider.isLoading) {
                  return const CircularProgressIndicator();
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // city
                      Text("Weather in ${weatherProvider.city} is like..."),

                      // 5 days weather info

                      SizedBox(
                        height: size.height * 0.5,
                        width: size.width * 0.9,
                        child: weatherInfoCount == 0
                            ? const Card(
                                child: Center(
                                    child: Text("There is no data available")),
                              )
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                ),
                                itemCount: weatherInfoCount,
                                itemBuilder: (context, index) => Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        " Date:  ${weatherProvider.listOfWeatherInfo[index].dt.toString()}",
                                      ),
                                      Text(
                                        " Temperture: ${weatherProvider.listOfWeatherInfo[index].main.temp.toString()}",
                                      ),
                                      Text(
                                        " Humidity: ${weatherProvider.listOfWeatherInfo[index].main.humidity.toString()}",
                                      ),
                                      Text(
                                        " Wind Speed: ${weatherProvider.listOfWeatherInfo[index].wind.speed.toString()}",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
