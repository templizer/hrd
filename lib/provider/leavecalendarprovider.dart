import 'dart:convert';

import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/data/source/network/model/employeeleavecalendar/Employeeleavecalendarresponse.dart';
import 'package:cnattendance/data/source/network/model/employeeleavecalendarbyday/Birthday.dart';
import 'package:cnattendance/data/source/network/model/employeeleavecalendarbyday/Holiday.dart'
    as holi;
import 'package:cnattendance/data/source/network/model/employeeleavecalendarbyday/EmployeeLeavesByDay.dart';
import 'package:cnattendance/data/source/network/model/employeeleavecalendarbyday/EmployeeLeavesByDayResponse.dart';
import 'package:cnattendance/model/LeaveByDay.dart';
import 'package:cnattendance/model/holiday.dart';
import 'package:cnattendance/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

import '../data/source/network/model/hollidays/Holidays.dart';

class LeaveCalendarProvider with ChangeNotifier {
  final Map<String, List<dynamic>> _employeeLeaveList = {};

  final List<LeaveByDay> _employeeLeaveByDayList = [];
  Holiday? _employeeHoliday = null;
  final List<Birthday> _employeeBirthdayList = [];

  int toggleValue = 0;

  bool isAd = true;

  Map<String, List<dynamic>> get employeeLeaveList {
    return _employeeLeaveList;
  }

  List<LeaveByDay> get employeeLeaveByDayList {
    return _employeeLeaveByDayList;
  }

  Holiday? get employeeHoliday {
    return _employeeHoliday;
  }

  List<Birthday> get employeeBirthdayList {
    return _employeeBirthdayList;
  }

  void changeToggle(int value) {
    toggleValue = value;
    notifyListeners();
  }

  Future<void> getIsAd() async {
    Preferences preferences = Preferences();

    isAd = await preferences.getEnglishDate();
    notifyListeners();
  }

  Future<Employeeleavecalendarresponse> getLeaves() async {
    Preferences preferences = Preferences();
    var uri =
        Uri.parse(await preferences.getAppUrl() + Constant.LEAVE_CALENDAR_API);

    String token = await preferences.getToken();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    try {
      final response = await http.get(uri, headers: headers);

      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        debugPrint(responseData.toString());

        final responseJson =
            Employeeleavecalendarresponse.fromJson(responseData);

        _employeeLeaveList.clear();

        for (var item in responseJson.data) {
          List<int> list = [];
          for (int i = 0; i < int.parse(item.leaveCount); i++) {
            list.add(i);
          }
          _employeeLeaveList.addAll({item.date: list});
        }

        notifyListeners();

        return responseJson;
      } else {
        var errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<EmployeeLeavesByDayResponse> getLeavesByDay(String value) async {
    Preferences preferences = Preferences();
    print("Leave date for " + value.toString());
    var uri =
        Uri.parse(await preferences.getAppUrl() + Constant.OFFICE_CALENDAR_API)
            .replace(queryParameters: {'leave_date': value});

    String token = await preferences.getToken();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    try {
      final response = await http.get(uri, headers: headers);

      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        debugPrint(responseData.toString());

        final responseJson = EmployeeLeavesByDayResponse.fromJson(responseData);

        makeLeaveByDayList(responseJson.data.employeeLeaves);
        makeHolidayList(responseJson.data.holidays);
        _employeeBirthdayList.clear();
        _employeeBirthdayList.addAll(responseJson.data.birthdays);
        notifyListeners();

        return responseJson;
      } else {
        var errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (error) {
      rethrow;
    }
  }

  void makeLeaveByDayList(List<EmployeeLeavesByDay> data) {
    _employeeLeaveByDayList.clear();
    for (var item in data) {
      _employeeLeaveByDayList.add(LeaveByDay(
          id: item.leaveId,
          name: item.userName,
          post: item.post,
          days: item.leaveDays,
          avatar: item.userAvatar));
    }
    notifyListeners();
  }

  Future<void> makeHolidayList(holi.Holiday? item) async {
    if (item != null) {
      Preferences preferences = Preferences();
      bool isAd = await preferences.getEnglishDate();

      DateTime tempDate = DateFormat("yyyy-MM-dd").parse(item.event_date);

      NepaliDateTime nepaliDate = tempDate.toNepaliDateTime();

      _employeeHoliday = Holiday(
          id: item.id,
          day: isAd
              ? DateFormat('dd').format(tempDate)
              : NepaliDateFormat('dd').format(nepaliDate),
          month: isAd
              ? DateFormat('MMM').format(tempDate)
              : NepaliDateFormat('MMMM').format(nepaliDate),
          title: item.event,
          description: item.description,
          dateTime: tempDate,
          isPublicHoliday: item.is_public_holiday);

    }else{
      _employeeHoliday = null;
    }

    notifyListeners();
  }
}
