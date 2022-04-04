import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:hyid/models/extract_arguments_screen.dart';
import 'package:hyid/screens/web/components/desktopSide.dart';

import 'package:hyid/classes/language.dart';
import 'package:hyid/localization/language_constants.dart';
import 'package:hyid/main.dart';
import 'package:hyid/screens/web/components/password_text_field.dart';
import 'package:hyid/screens/web/components/template_for_web.dart';
import 'package:hyid/screens/web/components/text_form_field.dart';
import 'package:hyid/screens/web/create_account.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hyid/hyeid_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_countdown_timer/index.dart';

class DesktopBody3 extends StatefulWidget {
  const DesktopBody3({
    Key? key,
  }) : super(key: key);

  @override
  State<DesktopBody3> createState() => _DesktopBody3State();
}

class _DesktopBody3State extends State<DesktopBody3> {
  bool checked = false;
  String phoneNumber = " ";
  String countryCode = " ";
  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }
  /**
   * timer
   * 
   * */

  late CountdownTimerController controller;
  int endTime = DateTime.now().millisecondsSinceEpoch +
      Duration(seconds: 60).inMilliseconds;
  @override
  void initState() {
    super.initState();
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  bool isPlaying = false;
  void onEnd() {
    return;
  }

  void restartTimer() {
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }
  // void _togglePasswordView() {
  //   setState(() {
  //     _isHidden = !_isHidden;
  //   });
  // }

  final _formKey = GlobalKey<FormState>();

  // void _submit() {
  //   final isValid = _formKey.currentState!.validate();
  //   if (!isValid) {
  //     return;
  //   }
  //   Navigator.of(context).pushNamed('/password-setup');
  //   _formKey.currentState!.save();
  // }

  final verificationCode = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    verificationCode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String validateError = '';
    dynamic validateFunc(value) {
      if (value!.isEmpty) {
        return getTranslated(context, 'required');
      } else if (validateError.length > 0) {
        return getTranslated(context, 'enter_valid_value');
      }
      return null;
    }

    Future signup({verificationCode}) async {
      Map data = {"verificationCode": verificationCode};
      print(data.toString());

      try {
        final response = await http.post(
          Uri.parse(
              'https://development.connectto.com:8085/hyeid-back/v2/user/verify'),
          headers: {"Accept": "*/*", "Content-Type": "application/json"},
          body: json.encode(data),
        );

        print(response.statusCode);
        if (response.statusCode == 200) {
          print('created');
          Navigator.pushReplacementNamed(context, "/");
        } else {
          validateFunc(verificationCode);
          print('other');
          print(response.statusCode);
        }
      } catch (e) {
        print('get an error');
        print(e);
      }
    }

    void onChangeField(val) {
      return;
    }

    Size size = MediaQuery.of(context).size;

    return TemplateForWeb(
      formKey: _formKey,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: size.height * 0.18, right: size.width * 0.15),
            width: size.width * 0.3,
            height: size.height * 0.08,
            child: Center(
              child: Text(
                getTranslated(context, 'account_verification'),
                style: const TextStyle(
                  color: Color.fromRGBO(34, 33, 32, 1),
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  height: 2.4,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 1),
                  blurRadius: 5,
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                ),
              ],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color.fromRGBO(34, 33, 32, 0.1),
                style: BorderStyle.solid,
                width: 1.0,
              ),
              color: const Color.fromRGBO(255, 255, 255, 1),
            ),

            margin: EdgeInsets.only(top: 27, right: size.width * 0.15),
            width: size.width * 0.3,
            // height: size.height * 0.35,
            //width: size.width * 0.7,
            padding: EdgeInsets.fromLTRB(
                size.width * 0.025, 0, size.width * 0.025, 0),
            //color: Color.fromRGBO(250, 250, 250, 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.022,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: Text(
                    getTranslated(context, "verification_text"),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 2.1,
                      color: Color.fromRGBO(34, 33, 32, 1),
                    ),
                  ),
                ),
                const Divider(
                  color: Color.fromRGBO(34, 33, 32, 0.25),
                  height: 25,
                  thickness: 1,
                  indent: 5,
                  endIndent: 5,
                ),
                Container(
                  width: size.width * 0.7,
                  child: Form(
                    key: _formKey,
                    // autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: size.height * 0.05),
                        TextFormWidget(
                            controller: verificationCode,
                            name: 'verification_code',
                            validateFunction: validateFunc,
                            labelText: 'labelText'),
                        const SizedBox(
                          height: 35,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getTranslated(context, 'dont_received_yet'),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 2.2,
                                color: Color.fromRGBO(34, 33, 32, 1),
                              ),
                            ),
                            Material(
                              type: MaterialType.transparency,
                              color: const Color.fromRGBO(250, 250, 247, 1),
                              elevation: 4,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(4),
                              ),
                              child: InkWell(
                                //splashColor: Colors.black26,
                                onTap: () {
                                  onEnd();
                                  restartTimer();
                                  print('tap resend');

                                  if (controller.isRunning) {
                                    controller.disposeTimer();
                                  } else {
                                    controller.start();
                                  }

                                  // if (controller.isRunning) {
                                  //   controller.disposeTimer();
                                  // } else {
                                  //   controller.start();
                                  // }
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      getTranslated(context, 'resend'),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color.fromRGBO(59, 158, 146, 1),
                                        height: 2,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Ink.image(
                                      image: const AssetImage(
                                        "assets/images/recend.png",
                                      ),
                                      width: 35,
                                      height: 35,
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 3),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromRGBO(34, 33, 32, 1),
                                    width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: CountdownTimer(
                                controller: controller,
                                textStyle: const TextStyle(
                                  color: Color.fromRGBO(34, 33, 32, 1),
                                  fontSize: 20,
                                  height: 2.0,
                                ),
                                onEnd: onEnd,
                                endTime: endTime,
                                endWidget: const Text(
                                  '00:00:00',
                                  style: TextStyle(
                                    color: Color.fromRGBO(34, 33, 32, 1),
                                    fontSize: 20,
                                    height: 2.6,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: ElevatedButton(
                                  child: Text(
                                    getTranslated(context, 'submit'),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    print('submit pressed');
                                    final isValid =
                                        _formKey.currentState!.validate();
                                    if (!isValid) {
                                      return;
                                    }
                                    _formKey.currentState!.save();
                                    signup(
                                      verificationCode: verificationCode.text,
                                    );

                                    // Navigator.of(context)
                                    //     .pushNamed('/password-setup');
                                    // _formKey.currentState!.save();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: const Color.fromRGBO(
                                        59,
                                        158,
                                        146,
                                        1,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 14),
                                      textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          height: 2.1,
                                          letterSpacing: 0.02,
                                          fontWeight: FontWeight.w700)),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 62,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
