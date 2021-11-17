import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class Location {
  Position? position;
  double? longitude;
  double? latitude;
  Location() {}
  Future<void> createLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      position = value;
      latitude = value.latitude;
      longitude = value.longitude;
      print(latitude);
      print(longitude);
    });
  }
}

class Weather {
  dynamic weatherData;
  Weather() {
    // _getWeatherDataFromAPI();
  }
  Future<dynamic> getWeatherData({double? latitude, double? longitude}) async {
    // both latitude and longitude are not given
    // so take location from device
    if (latitude == null || longitude == null) {
      Location location = Location();
      await location.createLocation();
      return await _getWeatherDataFromAPI(
          location.latitude!, location.longitude!);
    } else {
      return await _getWeatherDataFromAPI(latitude, longitude);
    }
  }

  Future<dynamic> _getWeatherDataFromAPI(
      double latitude, double longitude) async {
    await http
        .get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=' +
            latitude.toString() +
            '&lon=' +
            longitude.toString() +
            '&units=metric' +
            '&appid=3c5c64f802312d75cdfaed07cb45d141'))
        .then((html) {
      weatherData = html.body;
    });
    return weatherData;
  }
  // Future<dynamic> getWeatherData() async {
  //   return await getWeatherDataFromAPI();
  // }
}

void main(List<String> args) {
  Weather w = Weather();
}
