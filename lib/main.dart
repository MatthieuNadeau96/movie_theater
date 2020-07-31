import 'package:flutter/material.dart';
import 'package:movie_theater/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Theater App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff1E2739),
        primaryColorLight: Color(0xff2C374E),
        accentColor: Color(0xff9BBECF),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      home: HomeScreen(),
    );
  }
}
