import 'package:flutter/material.dart';
import 'package:movie_theater/model/seat.dart';
import 'package:movie_theater/model/time_slots.dart';

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
    //
    Seat(color: Colors.blue, isTaken: false, userSelected: false),
    Seat(color: Colors.blue, isTaken: true, userSelected: false),
    Seat(color: Colors.blue, isTaken: true, userSelected: false),
    Seat(color: Colors.blue, isTaken: false, userSelected: false),
    //
    Seat(color: Colors.blue, isTaken: false, userSelected: false),
    Seat(color: Colors.blue, isTaken: true, userSelected: false),
    Seat(color: Colors.blue, isTaken: true, userSelected: false),
    Seat(color: Colors.blue, isTaken: false, userSelected: false),
    //
    Seat(color: Colors.blue, isTaken: false, userSelected: false),
    Seat(color: Colors.blue, isTaken: true, userSelected: false),
    Seat(color: Colors.blue, isTaken: true, userSelected: false),
    Seat(color: Colors.blue, isTaken: false, userSelected: false),
    //
    Seat(color: Colors.blue, isTaken: false, userSelected: false),
    Seat(color: Colors.blue, isTaken: true, userSelected: false),
    Seat(color: Colors.blue, isTaken: true, userSelected: false),
    Seat(color: Colors.blue, isTaken: false, userSelected: false),
  ];
  return seats;
}

List<TimeSlots> getTimeSlots() {
  List<TimeSlots> timeSlots = [
    TimeSlots(time: '7:00', isSelected: true),
    TimeSlots(time: '7:30', isSelected: false),
    TimeSlots(time: '8:00', isSelected: false),
    TimeSlots(time: '8:30', isSelected: false),
    TimeSlots(time: '9:00', isSelected: false),
    TimeSlots(time: '9:30', isSelected: false),
    TimeSlots(time: '10:00', isSelected: false),
  ];
  return timeSlots;
}
