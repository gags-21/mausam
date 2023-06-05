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
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.08),
                child: const Text(
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

        // filtering data to 5 days only
        for (int i = 0; i < weatherInfoCount; i++) {
          if (i % 8 == 0) {
            weatherInfo.add(weatherProvider.listOfWeatherInfo[i]);
          }
        }

        // if loading data
        if (weatherProvider.isLoading) {
          return const CircularProgressIndicator();
        } else {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // headline
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.08),
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
                  height: 350,
                  child: weatherInfoCount == 0
                      ? const Card(
                          child:
                              Center(child: Text("There is no data available")),
                        )
                      : Padding(
                          padding: EdgeInsets.only(left: size.width * 0.08),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5, // weatherInfo.length,
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
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      if (index == 0)
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(0.5),
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                top: Radius.circular(10),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Current",
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .canvasColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      Padding(
                                        padding: const EdgeInsets.all(25.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.air,
                                                size: 15,
                                              ),
                                              Text(
                                                "${weatherInfo[index]["wind"]["speed"]}",
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w100,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              const Icon(
                                                Icons.water_drop_outlined,
                                                size: 15,
                                              ),
                                              Text(
                                                "${weatherInfo[index]["main"]["humidity"]}",
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w100,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
