// ignore_for_file: avoid_print

import 'package:geolocator/geolocator.dart';

class Location {
  late double latitude;
  late double longitude;

  Future<void> getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      //Pass the lat and long to the function
      latitude = position.latitude;
      longitude = position.longitude;
    }).catchError((e) {
      print(e);
    });
  }
}
