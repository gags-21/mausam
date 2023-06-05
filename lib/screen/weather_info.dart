import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';

class WeatherInfoScreen extends StatelessWidget {
  const WeatherInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 15.0, top: 100.0),
                child: Text(
                  "Weather Info",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ShowForecast(size: size),
            ],
          ),
        ),
      ),
    );
  }
}

class ShowForecast extends StatelessWidget {
  const ShowForecast({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    List weatherInfo = [];
    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, _) {
        final weatherInfoCount = weatherProvider.listOfWeatherInfo.length;
        // print("CountTTTTT = $weatherInfoCount");
        for (int i = 0; i < weatherInfoCount; i++) {
          if (i % 8 == 0) {
            weatherInfo.add(weatherProvider.listOfWeatherInfo[i]);
          }
        }
        print("Dateeee =${weatherInfo[1]["dt_txt"]}");

        if (weatherProvider.isLoading) {
          return const CircularProgressIndicator();
        } else {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // city
              // Text("Weather in ${weatherProvider.city} is like..."),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: RichText(
                  text: TextSpan(
                    text: "Weather in ",
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                    children: [
                      TextSpan(
                        text: weatherProvider.city,
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const TextSpan(
                        text: " is like...",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // 5 days weather info

              SizedBox(
                height: size.height * 0.4,
                child: weatherInfoCount == 0 //weatherInfoCount
                    ? const Card(
                        child:
                            Center(child: Text("There is no data available")),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: weatherInfo.length,
                        itemBuilder: (context, index) {
                          final date =
                              DateTime.parse(weatherInfo[index]["dt_txt"]);
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            child: Container(
                              width: 180,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      // "Month",
                                      DateFormat.MMM().format(date),
                                    ),
                                    Text(
                                      // "Date",
                                      DateFormat.d().format(date),
                                      style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      // "Year",
                                      DateFormat.y().format(date),
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "${weatherInfo[index]["weather"][0]["description"]} \n Weather",
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "${weatherInfo[index]["main"]["temp"]}\u00B0",
                                      style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Feels like \n ${weatherInfo[index]["main"]["feels_like"]}\u00B0",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
              ),
            ],
          );
        }
      },
    );
  }
}
