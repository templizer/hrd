import 'package:cnattendance/widget/buttonborder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;

  CustomAlertDialog(this.title);

  @override
  Widget build(BuildContext context) {
    var message = title.toString().toLowerCase().contains("null") ? "Restart the router and try again." : title;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icons/dialog_icon.png",
            width: 80,
            height: 80,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            textAlign: TextAlign.center,
            message,
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
                style: TextButton.styleFrom(
                    backgroundColor: HexColor("#036eb7"),
                    shape: ButtonBorder()),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(translate('common.close'),style: TextStyle(color: Colors.white)),
                )),
          )
        ],
      ),
    );
  }
}
