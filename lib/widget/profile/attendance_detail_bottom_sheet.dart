import 'package:cnattendance/provider/attendancereportprovider.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

class AttendanceDetailBottomSheet extends StatefulWidget {
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

  AttendanceDetailBottomSheet(
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
  State<StatefulWidget> createState() => AttendanceDetailBottomSheetState();
}

class AttendanceDetailBottomSheetState
    extends State<AttendanceDetailBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<AttendanceReportProvider>();
    return Container(
      decoration: RadialDecoration(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${translate('attendance_screen.attendance_summary')}",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.white,
                    )),
              ],
            ),
            Row(
              children: [
                Text(
                  provider.month[provider.selectedMonth].name,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  " ",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  widget.date,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
            Divider(color: Colors.transparent,height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  translate('attendance_screen.start_time'),
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                Text(
                  widget.start,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  translate('attendance_screen.end_time'),
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                Text(
                  widget.end,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
            Divider(
              color: Colors.white54,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  translate('attendance_screen.worked_hours'),
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  widget.workedHr,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
            if (widget.isOverTime)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    translate('attendance_screen.overtime'),
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    "+${widget.overTime}",
                    style: TextStyle(color: Colors.green, fontSize: 16),
                  ),
                ],
              ),
            if (widget.isUnderTime)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    translate('attendance_screen.undertime'),
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  Text(
                    "-${widget.underTime}",
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
