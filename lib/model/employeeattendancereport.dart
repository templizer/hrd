import 'package:flutter/material.dart';

class EmployeeAttendanceReport with ChangeNotifier {
  int id;
  String attendance_date;
  String week_day;
  String worked_hours;
  String working_hours;
  String check_in;
  String check_out;
  bool isOverTime;
  bool isUnderTime;
  String overTime;
  String underTime;

  EmployeeAttendanceReport({
    required this.id,
    required this.attendance_date,
    required this.week_day,
    required this.worked_hours,
    required this.working_hours,
    required this.check_in,
    required this.check_out,
    required this.isOverTime,
    required this.isUnderTime,
    required this.overTime,
    required this.underTime,
  });
}
