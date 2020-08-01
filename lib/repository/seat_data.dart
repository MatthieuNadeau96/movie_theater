import 'package:flutter/material.dart';
import 'package:movie_theater/model/seat.dart';

List<Seat> getSeats() {
  List<Seat> seats = [
    Seat(color: Colors.blue, isTaken: false, userSelected: false),
    Seat(color: Colors.blue, isTaken: false, userSelected: false),
    Seat(color: Colors.blue, isTaken: false, userSelected: false),
    Seat(color: Colors.blue, isTaken: false, userSelected: false),
    //
    Seat(color: Colors.blue, isTaken: true, userSelected: false),
    Seat(color: Colors.blue, isTaken: true, userSelected: false),
    Seat(color: Colors.blue, isTaken: true, userSelected: false),
    Seat(color: Colors.blue, isTaken: false, userSelected: false),
    //
    Seat(color: Colors.blue, isTaken: false, userSelected: false),
    Seat(color: Colors.blue, isTaken: false, userSelected: false),
    Seat(color: Colors.blue, isTaken: false, userSelected: false),
    Seat(color: Colors.blue, isTaken: false, userSelected: false),
    //
    Seat(color: Colors.blue, isTaken: false, userSelected: false),
    Seat(color: Colors.blue, isTaken: true, userSelected: false),
    Seat(color: Colors.blue, isTaken: true, userSelected: false),
    Seat(color: Colors.blue, isTaken: false, userSelected: false),
  ];
  return seats;
}
