import 'package:movie_theater/model/seat.dart';

class TimeSlots {
  String time;
  bool isSelected;
  List<Seat> seats;

  TimeSlots({
    this.time,
    this.isSelected,
    this.seats,
  });
}
