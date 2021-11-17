import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_weather_app/Climate/screens/google_map_screen.dart';
import 'package:flutter_weather_app/Climate/services/location.dart';
import 'package:flutter_weather_app/Climate/utilities/constants.dart';

import 'package:weather_icons/weather_icons.dart';

// import 'constants';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double? _latitude = 0;
  double? _longitude = 0;
  String? temp = null;
  String? lowTemp = null;
  String? highTemp = null;
  String? cityAndCountry = null;
  String cloud = '--';
  String wind = '--';
  String humidity = '--';

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance!.addPostFrameCallback((_) {});
    getWeatherData();
  }

  // getD({double latitude,double longitude}) async {
  getWeatherData({double? latitude, double? longitude}) async {
    Weather w = Weather();
    print('hi????');
    print('lat $latitude + long $longitude');
    var weatherData =
        await w.getWeatherData(latitude: latitude, longitude: longitude);

    if (latitude != null && longitude != null) {
      Location location = Location();
      await location.createLocation();
      _latitude = location!.latitude;
      _longitude = location!.longitude;
    }

    setState(() {
      temp = jsonDecode(weatherData)['main']['temp'].toInt().toString() + '°';
      lowTemp = 'L: ' +
          jsonDecode(weatherData)['main']['temp_min'].toInt().toString() +
          '°';
      highTemp = 'H: ' +
          jsonDecode(weatherData)['main']['temp_max'].toInt().toString() +
          '°';
      cityAndCountry = jsonDecode(weatherData)['name'] +
          ', ' +
          jsonDecode(weatherData)['sys']['country'];
      cloud = jsonDecode(weatherData)['clouds']['all'].toString() + ' %';
      wind = jsonDecode(weatherData)['wind']['speed'].toString() + ' m/s';
      humidity = jsonDecode(weatherData)['main']['humidity'].toString() + ' %';
      // print(hh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: kLinearGradientBackground,
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Tooltip(
                    message: 'Current location',
                    child: TextButton(
                      onPressed: () {
                        getWeatherData();
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                      ),
                    ),
                  ),
                  Tooltip(
                    message: 'Pick a location',
                    child: TextButton(
                      onPressed: () async {
                        var result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MapSample(
                                  latitude: _latitude!,
                                  longitude: _longitude!)),
                        );
                        print('result is $result');
                        var latitude = result.latitude;
                        var longitude = result.longitude;
                        print('lat $latitude + long $longitude');
                        // get the lant and long from the map to get the
                        // weather info..
                        getWeatherData(
                            latitude: latitude, longitude: longitude);
                      },
                      child: Icon(
                        IconData(58284, fontFamily: 'MaterialIcons'),
                        size: 50.0,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(WeatherIcons.humidity),
                                        SizedBox(width: 10),
                                        Text(
                                          humidity,
                                          style: kDetailsTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(WeatherIcons.wind),
                                      SizedBox(width: 10),
                                      Text(
                                        wind,
                                        style: kDetailsTextStyle,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(WeatherIcons.cloud),
                                      SizedBox(width: 10),
                                      Text(
                                        cloud,
                                        style: kDetailsTextStyle,
                                      ),
                                    ],
                                  ),
                                ]),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(
                              lowTemp == null ? '--' : lowTemp!,
                              style: kDetailsTextStyle,
                              // style: kTempTextStyle,
                            ),
                            Text(
                              temp == null ? '--' : temp!,
                              style: kTempTextStyle,
                            ),
                            Text(
                              highTemp == null ? '--' : highTemp!,
                              style: kDetailsTextStyle,
                              // style: kTempTextStyle,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              cityAndCountry == null ? '--' : cityAndCountry!,
                              style: kDetailsTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
