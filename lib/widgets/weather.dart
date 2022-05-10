import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:listen_me/services/weather_services.dart';
import 'package:listen_me/theme.dart';

import '../services/weather_services.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({Key? key}) : super(key: key);

  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  dynamic weatherData;
  late String cityName = "Sukabumi";

  Future<dynamic> _fecthDataWeather() async {
    var weather = await WeatherServices().getCityWeather(cityName);
    return weatherData = weather;
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formatter = DateFormat('E, d MMMM');
    String formattedDate = formatter.format(now);

    return FutureBuilder<dynamic>(
        future: _fecthDataWeather(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formattedDate,
                      style: weateherDate,
                    ),
                    Text(
                      weatherData['main']['temp'].toString() + ' °C',
                      style: weateherTemp,
                    ),
                    Text(
                      weatherData['weather'][0]['main'],
                      style: weateherStatus,
                    ),
                    Text(
                      weatherData['name'],
                      style: weateherLocation,
                    ),
                    IconButton(
                        padding: const EdgeInsets.all(0),
                        alignment: Alignment.centerLeft,
                        icon: const Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                        onPressed: () => _showDialogEditLocation(context)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 130,
                      height: 130,
                      child: CachedNetworkImage(
                        imageUrl: WeatherServices().getWeatherBackground(
                            weatherData['weather'][0]['main'].toString()),
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xff344a54)),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ],
                )
              ],
            );
          } else {
            // ignore: prefer_const_constructors
            return Center(
                child: const CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xff344a54))));
          }
        });
  }

  _showDialogEditLocation(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Ganti Lokasi"),
            content: TextField(
              onChanged: (value) {
                cityName = value;
              },
              decoration: const InputDecoration(hintText: "Lokasi"),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Kembali")),
              TextButton(
                  onPressed: () async {
                    var weather =
                        await WeatherServices().getCityWeather(cityName);
                    setState(() {
                      weatherData = weather;
                    });

                    Navigator.pop(context);
                  },
                  child: const Text("Simpan")),
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
          );
        });
  }
}
