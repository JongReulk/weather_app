import 'dart:convert';

import 'package:geolocator/geolocator.dart';

class MyLocation {
  late double longitude2;
  late double latitude2;

  Future<void> getMyCurrentLocation() async{
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      longitude2 = position.longitude;
      latitude2 = position.latitude;
      print(longitude2);
      print(latitude2);
    } catch(e) {
      print('There was a problem with the Internet connection');
    }
  }
}