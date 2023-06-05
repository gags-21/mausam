import 'package:flutter/material.dart';
import 'package:hover_widget/hover_widget.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/screen/weather_info.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // provider
    final weatherProvider = Provider.of<WeatherProvider>(context);
    // controllers
    final searchController = TextEditingController();
    // screen size
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // background

          // // sun
          // Positioned(
          //   right: size.width * -0.4,
          //   top: size.height * -0.3,
          //   child: Image.asset("images/sun.png"),
          // ),

          // sun
          Positioned(
            right: -200,
            top: size.height * -0.3,
            child: Image.asset("images/sun.png"),
          ),
          // Positioned(
          //   left: size.width * 0.2,
          //   top: size.height * 0.07,
          //   child: Transform(
          //     transform: Matrix4.rotationY(3.14),
          //     child: Image.asset("/images/cloud.png"),
          //   ),
          // ),
          // Positioned(
          //   right: size.width * 0.2,
          //   top: size.height * 0.2,
          //   child: Image.asset("/images/cloud.png"),
          // ),
          // Positioned(
          //   right: size.width * 0.6,
          //   top: size.height * 0.15,
          //   child: Transform.scale(
          //       scale: 5, child: Image.asset("/images/cloud.png")),
          // ),

          // Positioned(
          //   right: size.width * 0.02,
          //   top: size.height * 0.02,
          //   child: Image.asset("/images/cloud.png"),
          // ),

          // main container
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(.03),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(.1),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(100.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Know your weather",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
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
                    ButtonFeedback(
                      child: ElevatedButton(
                        onPressed: () {
                          weatherProvider
                              .setWeatherDetails(
                                  cityOriZipCode: searchController.text)
                              .then(
                                (v) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const WeatherInfoScreen(),
                                  ),
                                ),
                              )
                              .catchError((error) {
                            String error = weatherProvider.errorMsg ==
                                    "Please enter a valid city or zip code"
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
                          fixedSize:
                              MaterialStateProperty.all(const Size(160, 40)),
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
