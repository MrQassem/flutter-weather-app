import 'package:flutter/material.dart';
import 'package:flutter_weather_app/Climate/screens/location_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(backgroundColor: Color(0xFF100F1D)),
        scaffoldBackgroundColor: Color(0xFF100F1D),
        textTheme: TextTheme(

            // bodyText1: TextStyle(color: Colors.green),
            ),
      ),
      routes: <String, WidgetBuilder>{
        '/': (contect) => LocationScreen(),
      },
    );
  }
}
