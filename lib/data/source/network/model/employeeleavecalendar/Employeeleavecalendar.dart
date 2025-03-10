class Employeeleavecalendar {
  Employeeleavecalendar({
    required this.date,
    required this.leaveCount,
  });

  factory Employeeleavecalendar.fromJson(dynamic json) {
    return Employeeleavecalendar(
      date: json['date'].toString() ?? "",
      leaveCount: json['leave_count'].toString() ?? "0",
    );
  }

  String date;
  String leaveCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['leave_count'] = leaveCount;
    return map;
  }
}
