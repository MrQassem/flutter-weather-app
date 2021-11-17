import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({Key? key}) : super(key: key);

  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select A location'),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'hi result');
            },
            child: Text('hi'),
          )
        ],
      ),
    );
  }
}

class MapSample extends StatefulWidget {
  double latitude;
  double longitude;
  // MapSample(@required this.latitude, @required this.longitude);
  MapSample({Key? key, required this.latitude, required this.longitude})
      : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  double? latitude;
  double? longitude;
  CameraPosition? _kGooglePlex;
  CameraPosition? _kLake;
  @override
  void initState() {
    latitude = widget.latitude;
    longitude = widget.longitude;
    _kGooglePlex = CameraPosition(
      target: LatLng(latitude!, longitude!),
      // target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 17.4746,
    );

// initial camera position
    _kLake = CameraPosition(
        bearing: 192.8334901395799,
        // target: LatLng(37.43296265331129, -122.08832357078792),
        target: LatLng(latitude!, longitude!),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);
  }

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick a location'),
      ),
      body: Stack(children: [
        GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: _kGooglePlex!,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          onLongPress: (argument) async {
            print(argument.latitude);
            print(argument.longitude);
            Navigator.pop(context, argument);
            // Weather w = Weather();
            // await w
            //     .getWeatherData(
            //         latitude: argument.latitude, longitude: argument.longitude)
            //     .then((value) {
            //   print(jsonDecode(value)['main']['temp']);
            // });
          },
        ),
        Positioned(
          top: 10,
          left: 10,
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Colors.blue.shade400,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Tooltip(
                message: 'Hold on a location to get weather info',
                child: Icon(
                  Icons.info,
                  size: 30,
                  // color: Colors.blue.shade400,
                ),
              ),
            ),
          ),
        ),
      ]),
      // true==true? Text('hi'):
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake!));
  }
}
