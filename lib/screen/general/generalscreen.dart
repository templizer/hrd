import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class GeneralScreen extends StatelessWidget {
  var outputDate = "".obs;

  Future<void> checkAd(DateTime tempDate) async {
    Preferences preferences = Preferences();
    final isAd = await preferences.getEnglishDate();
    if (!isAd) {
      outputDate.value =
          NepaliDateFormat("dd-MM-yyyy").format(tempDate.toNepaliDateTime());
    }
  }

  @override
  Widget build(BuildContext context) {
    final param = Get.arguments;

    if (param["date"] != "") {
      DateTime tempDate = DateFormat("yyyy-MM-dd").parse(param["date"]);
      var outputFormat = DateFormat('MM-dd-yyyy');
      outputDate.value = outputFormat.format(tempDate);

      checkAd(tempDate);
    }
    return Scaffold(
      body: Container(
        decoration: RadialDecoration(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(translate('general_screen.notification_detail'),
                style: TextStyle(color: Colors.white)),
            elevation: 0,
          ),
          body: SafeArea(
            child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      color: Colors.white10,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              param["title"],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 21),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                        visible: outputDate != "" ? true : false,
                        child: SizedBox(
                          height: 10,
                        )),
                    Visibility(
                      visible: outputDate != "" ? true : false,
                      child: Row(
                        children: [
                          Spacer(),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Obx(
                              () => Text(
                                "${translate('general_screen.published_date')} : " +
                                    outputDate.value,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Expanded(
                      child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          margin: EdgeInsets.zero,
                          color: Colors.transparent,
                          child: SingleChildScrollView(
                            child: Container(
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                param["message"],
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          )),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
