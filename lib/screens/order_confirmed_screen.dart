import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:movie_theater/screens/home_screen.dart';

class OrderConfirmedScreen extends StatefulWidget {
  @override
  _OrderConfirmedScreenState createState() => _OrderConfirmedScreenState();
}

class _OrderConfirmedScreenState extends State<OrderConfirmedScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 5);
    return Timer(duration, route);
  }

  route() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Container(
              child: FlareActor(
                'assets/MyCheckmark.flr',
                alignment: Alignment.center,
                color: Theme.of(context).accentColor,
                fit: BoxFit.contain,
                animation: 'Animate MyCheckmark',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
