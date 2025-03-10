class EmployeeAttendance {
  EmployeeAttendance({
    required this.id,
    required this.attendanceDate,
    required this.weekDay,
    required this.workedhrs,
    required this.checkIn,
    required this.checkOut,
    required this.isOverTime,
    required this.isUnderTime,
    required this.overTime,
    required this.underTime,
    required this.workingHour,
  });

  factory EmployeeAttendance.fromJson(dynamic json) {
    return EmployeeAttendance(
        id: json['id'],
        attendanceDate: json['attendance_date_nepali'].toString() ?? "",
        weekDay: json['week_day'].toString() ?? "",
        workedhrs: json['worked_hours'] != null ? json["worked_hours"].toString() : "-",
        checkIn: json['check_in'].toString() ?? "-",
        checkOut: json['check_out'].toString() ?? "-",
        workingHour: json['working_hours']?? "-",
        isOverTime: json['is_overtime']?? false,
        isUnderTime: json['is_undertime']?? false,
        overTime: json['overtime'].toString() ?? "-",
        underTime: json['undertime'].toString() ?? "-");
  }

  int id;
  String attendanceDate;
  String weekDay;
  String? workedhrs;
  String checkIn;
  String checkOut;
  bool isOverTime;
  bool isUnderTime;
  String overTime;
  String underTime;
  String workingHour;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['attendance_date'] = attendanceDate;
    map['week_day'] = weekDay;
    map['check_in'] = checkIn;
    map['check_out'] = checkOut;
    return map;
  }
}
