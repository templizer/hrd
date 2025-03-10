import 'dart:convert';
import 'dart:io';

import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/data/source/network/connect.dart';
import 'package:cnattendance/data/source/network/model/leaveissue/IssueLeaveResponse.dart';
import 'package:cnattendance/data/source/network/model/tadadetail/tadadetailresponse.dart';
import 'package:cnattendance/data/source/network/model/tadalist/tadalistresponse.dart';
import 'package:cnattendance/utils/constant.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TadaRepository {
  Future<TadaListResponse> getTadaList() async {
    Preferences preferences = Preferences();
    String token = await preferences.getToken();

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    try {
      final response =
          await Connect().getResponse(Constant.TADA_LIST_URL, headers);
      debugPrint(response.body.toString());

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final tadaResponse = TadaListResponse.fromJson(responseData);

        return tadaResponse;
      } else {
        var errorMessage = responseData['message'];
        print(errorMessage);
        throw errorMessage;
      }
    } catch (e) {
      throw unknownError(e);
    }
  }

  Future<TadaDetailResponse> getTadaDetail(String tadaId) async {
    Preferences preferences = Preferences();
    String token = await preferences.getToken();

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    try {
      final response = await Connect()
          .getResponse(Constant.TADA_DETAIL_URL + "/${tadaId}", headers);
      debugPrint(response.body.toString());

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final tadaResponse = TadaDetailResponse.fromJson(responseData);

        return tadaResponse;
      } else {
        var errorMessage = responseData['message'];
        print(errorMessage);
        throw errorMessage;
      }
    } catch (e) {
      throw unknownError(e);
    }
  }

  Future<IssueLeaveResponse> createTada(String title, String description,
      String expenses, List<PlatformFile> fileList) async {
    Preferences preferences = Preferences();
    var uri = Uri.parse(await preferences.getAppUrl() + Constant.TADA_STORE_URL);

    String token = await preferences.getToken();

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Content-type': 'multipart/form-data',
      'Authorization': 'Bearer $token'
    };

    var requests = http.MultipartRequest('POST', uri);
    requests.headers.addAll(headers);

    requests.fields.addAll({
      "title": title,
      "description": description,
      "total_expense": expenses,
    });

    for (var filed in fileList) {
      final file = File(filed.path!);
      final stream = http.ByteStream(Stream.castFrom(file.openRead()));
      final length = await file.length();

      final multipartFile = http.MultipartFile('attachments[]', stream, length,
          filename: filed.name);
      requests.files.add(multipartFile);
    }
    final responseStream = await requests.send();

    final response = await http.Response.fromStream(responseStream);
    debugPrint(response.toString());
    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      final tadaResponse = IssueLeaveResponse.fromJson(responseData);
      return tadaResponse;
    } else {
      var errorMessage = responseData['message'];
      print(errorMessage);
      throw errorMessage;
    }
  }

  Future<bool> getIsAd() async {
    Preferences preferences = Preferences();
    return await preferences.getEnglishDate();
  }
}
