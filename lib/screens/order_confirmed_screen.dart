import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:movie_theater/screens/home_screen.dart';

class OrderConfirmedScreen extends StatelessWidget {
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
            // child: ,
            // child: Icon(
            //   Icons.check_rounded,
            //   color: Colors.white,
            //   size: 60,
            // ),
          ),
        ),
      ),
    );
  }
}
