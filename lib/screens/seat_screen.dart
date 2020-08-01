import 'package:flutter/material.dart';
import 'package:movie_theater/widgets/projector.dart';

class SeatScreen extends StatefulWidget {
  @override
  _SeatScreenState createState() => _SeatScreenState();
}

class _SeatScreenState extends State<SeatScreen> {
  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      size: 28,
                      color: Theme.of(context).canvasColor.withOpacity(0.8),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Container(
                    width: deviceSize.width * 0.6,
                    child: Center(
                      child: Text(
                        'Choose Seats',
                        maxLines: 1,
                        // minFontSize: 12,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      size: 28,
                      color: Colors.transparent,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              SizedBox(height: 60),
              Container(
                height: 50,
                width: deviceSize.width * 0.75,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Projector(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
