import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:weather_app/clock.dart';
import 'package:weather_app/dateTime.dart';
import 'package:weather_app/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late VideoPlayerController _controller;

  final dio = Dio();
  String url =
      "https://api.weatherapi.com/v1/current.json?key=YOUR API KEY&q=rawalpindi&aqi=no";
  String forecast =
      "http://api.weatherapi.com/v1/forecast.json?key=YOUR API KEY&q=rawalpindi&days=5&aqi=no&alerts=no";

  getData() async {
    var response = await dio.get(url);
    var res = response.data;
    return res;
  }

  getForecast() async {
    var response = await dio.get(forecast);
    var res = response.data;
    return res;
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/cloudy.mp4')
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size?.width ?? 0,
                height: _controller.value.size?.height ?? 0,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          // You can add your UI content here.
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DigitalClock(),
                DayAndDateWidget(),
                gap20(),
                Container(
                  height: 170,
                  width: Get.width - 50,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: FutureBuilder(
                      future: getForecast(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        var snap = snapshot.data;
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: SpinKitFadingCube(
                              color: Colors.white,
                              size: 30.0,
                            ),
                          );
                        }
                        if (snapshot.hasError) {}
                        try {
                          var snapy = snap['forecast']['forecastday'];
                          return ListView.builder(
                            itemCount: snapy.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return weather(snapy[index]);
                            },
                          );
                        } catch (e) {
                          return Center(
                            child: Text(
                              e.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          );
                        }
                      }),
                ),
                gap20(),
                Container(
                  height: 250,
                  width: Get.width - 50,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 20),
                    child: FutureBuilder(
                        future: getData(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          var snap = snapshot.data;
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: SpinKitFadingCube(
                                color: Colors.white,
                                size: 30.0,
                              ),
                            );
                          }
                          if (snapshot.hasError) {}
                          try {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(snap['location']['name'] +
                                        ' , ' +
                                        snap['location']['country']),
                                    const Icon(Icons.more_horiz_outlined)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${snap['current']['temp_c'].toString().split('.')[0]}°",
                                          style: TextStyle(fontSize: 50),
                                        ),
                                        Text(
                                          snap['current']['condition']['text'],
                                        ),
                                        gap10(),
                                        Text(
                                            "Humidity ${snap['current']['humidity']}%"),
                                        gap10(),
                                      ],
                                    ),
                                    const GlowIcon(
                                      Icons.sunny,
                                      color: Colors.yellow,
                                      size: 120,
                                    )
                                  ],
                                )
                              ],
                            );
                          } catch (e) {
                            return Center(
                              child: Text(
                                e.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            );
                          }
                        }),

                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
