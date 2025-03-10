import 'package:cnattendance/provider/changepasswordprovider.dart';
import 'package:cnattendance/utils/navigationservice.dart';
import 'package:cnattendance/widget/buttonborder.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ChangePasswordProvider(), child: ChangePassword());
  }
}

class ChangePassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _form = GlobalKey<FormState>();

  late ScrollController scrollController;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _form.currentState!.dispose();
    scrollController.dispose();
    super.dispose();
  }

  hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(hideKeyboard);
    super.initState();
  }

  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool validateField(String value) {
    if (value.isEmpty) {
      return false;
    }
    return true;
  }

  void changePassword() async {
    final validate = _form.currentState!.validate();

    if (validate) {
      setState(() {
        EasyLoading.show(
            status: "Please wait..", maskType: EasyLoadingMaskType.clear);
      });

      try {
        final response =
            await Provider.of<ChangePasswordProvider>(context, listen: false)
                .changePassword(
                    _oldPasswordController.text,
                    _newPasswordController.text,
                    _confirmPasswordController.text);

        if (!mounted) {
          return;
        }
        if (response.statusCode == 200) {
          Navigator.pop(context);
          NavigationService().showSnackBar("Password Alert", response.message);
        } else {
          NavigationService().showSnackBar("Password Alert", response.message);
        }
      } catch (e) {
        NavigationService().showSnackBar("Password Alert", e.toString());
      }

      setState(() {
        EasyLoading.dismiss(animation: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          title: Text(translate('change_password_screen.change_password')),
          backgroundColor: Colors.transparent,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20),
          child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: HexColor("#036eb7"),
                  shape: ButtonBorder(),
                  fixedSize: Size(double.maxFinite, 55)),
              onPressed: () {
                changePassword();
              },
              child: Text(
                translate('change_password_screen.change_password'),
                style: TextStyle(color: Colors.white),
              )),
        ),
        body: Form(
          key: _form,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  obscureText: _obscureText,
                  controller: _oldPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (!validateField(value!)) {
                      return "Empty Field";
                    }
                    return null;
                  },
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: translate('change_password_screen.old_password'),
                    hintStyle: TextStyle(color: Colors.white70),
                    prefixIcon: Icon(Icons.lock, color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.white24,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(0),bottomLeft: Radius.circular(0),bottomRight: Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(0),bottomLeft: Radius.circular(0),bottomRight: Radius.circular(10))),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(0),bottomLeft: Radius.circular(0),bottomRight: Radius.circular(10))),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(0),bottomLeft: Radius.circular(0),bottomRight: Radius.circular(10))),
                    suffixIcon: InkWell(
                      onTap: _toggle,
                      child: Icon(
                        _obscureText
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        size: 15.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: _obscureText,
                  controller: _newPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (!validateField(value!)) {
                      return "Empty Field";
                    } else {
                      if (_newPasswordController.text !=
                          _confirmPasswordController.text) {
                        return "Password does not match";
                      }
                    }
                    return null;
                  },
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: translate('change_password_screen.new_password'),
                    hintStyle: TextStyle(color: Colors.white70),
                    prefixIcon: Icon(Icons.lock, color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.white24,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(0),bottomLeft: Radius.circular(0),bottomRight: Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(0),bottomLeft: Radius.circular(0),bottomRight: Radius.circular(10))),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(0),bottomLeft: Radius.circular(0),bottomRight: Radius.circular(10))),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(0),bottomLeft: Radius.circular(0),bottomRight: Radius.circular(10))),
                    suffixIcon: InkWell(
                      onTap: _toggle,
                      child: Icon(
                        _obscureText
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        size: 15.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: _obscureText,
                  controller: _confirmPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (!validateField(value!)) {
                      return "Empty Field";
                    } else {
                      if (_newPasswordController.text !=
                          _confirmPasswordController.text) {
                        return "Password does not match";
                      }
                    }

                    return null;
                  },
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: translate('change_password_screen.confirm_password'),
                    hintStyle: TextStyle(color: Colors.white70),
                    prefixIcon: Icon(Icons.lock, color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.white24,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(0),bottomLeft: Radius.circular(0),bottomRight: Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(0),bottomLeft: Radius.circular(0),bottomRight: Radius.circular(10))),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(0),bottomLeft: Radius.circular(0),bottomRight: Radius.circular(10))),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(0),bottomLeft: Radius.circular(0),bottomRight: Radius.circular(10))),
                    suffixIcon: InkWell(
                      onTap: _toggle,
                      child: Icon(
                        _obscureText
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        size: 15.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
