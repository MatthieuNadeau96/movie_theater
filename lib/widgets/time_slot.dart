import 'package:flutter/material.dart';
import 'package:movie_theater/repository/seat_data.dart';
import 'package:movie_theater/model/time_slots.dart';

class TimeSlot extends StatefulWidget {
  @override
  _TimeSlotState createState() => _TimeSlotState();
}

class _TimeSlotState extends State<TimeSlot> {
  List<TimeSlots> timeSlots = List<TimeSlots>();

  String selectedTime = '7:00';

  @override
  void initState() {
    super.initState();
    timeSlots = getTimeSlots();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: timeSlots.length,
        itemBuilder: (context, index) {
          var t = timeSlots[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                if (t.time != selectedTime) {
                  selectedTime = t.time;
                  t.isSelected = true;
                }
              });
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.symmetric(
                horizontal: 2,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                color: t.isSelected && t.time == selectedTime
                    ? Theme.of(context).primaryColorLight
                    : Theme.of(context).primaryColor.withOpacity(0.25),
                borderRadius: BorderRadius.circular(
                  30,
                ),
              ),
              child: Center(
                child: Text(
                  timeSlots[index].time,
                  style: TextStyle(
                    color: Theme.of(context).canvasColor,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
