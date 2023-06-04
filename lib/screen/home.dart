import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/screen/weather_info.dart';
import 'package:weather_app/services/api.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // provider
    final weatherProvider = Provider.of<WeatherProvider>(context);
    // controllers
    final searchController = TextEditingController();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Know your weather"),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 150,
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: "City or Zip Code",
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  weatherProvider
                      .setWeatherDetails(cityOriZipCode: searchController.text)
                      .then(
                        (v) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WeatherInfoScreen(),
                          ),
                        ),
                      )
                      .catchError((error) {
                    String error = weatherProvider.errorMsg ==
                            "Both City and Zip are empty"
                        ? "Insufficient data"
                        : "Somthing went wrong";
                    String errorMsg = weatherProvider.errorMsg;
                    return showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(error),
                        content: Text(errorMsg),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("OK"),
                          ),
                        ],
                      ),
                    );
                  });
                },
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(const Size(150, 30)),
                ),
                child: weatherProvider.isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : const Text("Search"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
