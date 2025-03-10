import 'package:cnattendance/widget/buttonborder.dart';
import 'package:cnattendance/widget/profile/attendance_detail_bottom_sheet.dart';
import 'package:flutter/material.dart';

class AttendanceCardView extends StatelessWidget {
  final int index;
  final String date;
  final String day;
  final String workedHr;
  final String workingHr;
  final String start;
  final String end;
  final bool isUnderTime;
  final bool isOverTime;
  final String overTime;
  final String underTime;

  AttendanceCardView(
    this.index,
    this.date,
    this.day,
    this.start,
    this.end,
    this.workedHr,
    this.workingHr,
    this.isOverTime,
    this.isUnderTime,
    this.overTime,
    this.underTime,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white12,
      shape: ButtonBorder(),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              useRootNavigator: true,
              builder: (context) {
                return AttendanceDetailBottomSheet(
                    date,
                    day,
                    start,
                    end,
                    workedHr,
                    workingHr,
                    isOverTime,
                    isUnderTime,
                    overTime,
                    underTime);
              });
        },
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(date,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                        textAlign: TextAlign.center),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(day,
                        style: TextStyle(fontSize: 15, color: Colors.white70),
                        textAlign: TextAlign.center),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                      child: Text(start,
                          style: TextStyle(fontSize: 15, color: Colors.white),
                          textAlign: TextAlign.center),
                    )),
                Expanded(
                    flex: 2,
                    child: Container(
                      child: Text(end,
                          style: TextStyle(fontSize: 15, color: Colors.white),
                          textAlign: TextAlign.center),
                    )),
                Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.remove_red_eye,
                      color: Colors.white,
                      size: 20,
                    )),
              ],
            )),
      ),
    );
  }
}
