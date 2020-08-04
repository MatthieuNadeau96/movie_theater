import 'package:flutter/material.dart';
import 'package:movie_theater/model/seat.dart';
import 'package:movie_theater/repository/seat_data.dart';
import 'package:movie_theater/screens/order_confirmed_screen.dart';
import 'package:movie_theater/widgets/projector.dart';
import 'package:movie_theater/widgets/time_slot.dart';

class SeatScreen extends StatefulWidget {
  @override
  _SeatScreenState createState() => _SeatScreenState();
}

class _SeatScreenState extends State<SeatScreen> {
  List<Seat> seats = List<Seat>();

  double totalPrice = 0;
  int numberOfSelectedSeats = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    seats = getSeats();
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).canvasColor.withOpacity(0.9),
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
            SizedBox(height: 15),
            Container(
              height: 50,
              width: deviceSize.width * 0.75,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Projector(),
            ),
            SizedBox(height: 60),
            Container(
              height: deviceSize.height * 0.40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.topCenter,
                child: GridView.count(
                  crossAxisCount: 8,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 5,
                  childAspectRatio:
                      ((deviceSize.width / 4) / (deviceSize.height / 8)),
                  shrinkWrap: true,
                  children: [
                    ...seats.map(
                      (Seat seat) => GestureDetector(
                        onTap: () {
                          if (!seat.isTaken)
                            setState(() {
                              seat.userSelected = !seat.userSelected;
                              print(_getTotal(seats));
                              numberOfSelectedSeats = _getTotal(seats).length;
                              if (_getTotal(seats).isNotEmpty) {
                                totalPrice =
                                    _getTotal(seats).reduce((a, b) => a + b);
                              } else {
                                totalPrice = 0;
                              }
                            });
                        },
                        child: Container(
                          height: 2,
                          width: 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: seat.isTaken
                                ? Theme.of(context).primaryColorDark
                                : seat.userSelected
                                    ? Theme.of(context).accentColor
                                    : Theme.of(context).primaryColorLight,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Selected',
                        style: TextStyle(
                          color: Theme.of(context).canvasColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Available',
                        style: TextStyle(
                          color: Theme.of(context).canvasColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorDark,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Reserved',
                        style: TextStyle(
                          color: Theme.of(context).canvasColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              constraints: BoxConstraints(
                maxHeight: deviceSize.height * 0.12,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Theme.of(context).primaryColorDark,
                ),
                child: (totalPrice > 0)
                    ? Container(
                        height: deviceSize.height * 0.12,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '$numberOfSelectedSeats seats',
                                    style: TextStyle(
                                      color: Theme.of(context).canvasColor,
                                      // fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Pay \$${totalPrice.toStringAsFixed(2)} ',
                                    style: TextStyle(
                                      color: Theme.of(context).canvasColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            FlatButton(
                              padding: EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 40,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        OrderConfirmedScreen(),
                                  ),
                                );
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              color: Theme.of(context).primaryColorLight,
                              child: Text(
                                'CONFIRM',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).canvasColor,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : TimeSlot(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List _getTotal(List seats) {
  List userSelectedSeats = [];
  seats
      .map((e) => e.userSelected ? userSelectedSeats.add(9.12) : null)
      .toList();
  return userSelectedSeats;
}
