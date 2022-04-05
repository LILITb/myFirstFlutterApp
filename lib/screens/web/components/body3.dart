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

import 'package:timer_builder/timer_builder.dart';

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
  String errorMessage = '';
  bool resendCode = true;

  //timer
  late DateTime alert;

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  @override
  void initState() {
    super.initState();
    //timer
    alert = DateTime.now().add(Duration(seconds: 60));
  }

  final _formKey = GlobalKey<FormState>();

  final verificationCode = TextEditingController();

  @override
  void dispose() {
    verificationCode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dynamic validateFunc(value) {
      print('validateerror ${errorMessage}');
      if (value!.isEmpty) {
        return getTranslated(context, 'required');
      } else if (errorMessage.length > 0) {
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
          print(response.statusCode);

          Map responseBody = json.decode(response.body);
          print(responseBody.toString());
          setState(() {
            errorMessage = responseBody['error_description'];
          });
          if (_formKey.currentState!.validate()) {
            Navigator.pushReplacementNamed(context, "/");
          } else {}
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
            padding: EdgeInsets.fromLTRB(
                size.width * 0.025, 0, size.width * 0.025, 0),
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
                            labelText: 'labelText',
                            errorMessage: errorMessage),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          resendCode == true
                              ? getTranslated(context, 'resend_activation_code')
                              : '',
                          style: TextStyle(
                            color: Color.fromRGBO(59, 158, 146, 1),
                          ),
                        ),
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
                                onTap: () {
                                  print('tap resend');
                                  if (resendCode) return;
                                  setState(() {
                                    alert = DateTime.now()
                                        .add(Duration(seconds: 60));
                                  });
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      getTranslated(context, 'resend'),
                                      style: TextStyle(
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
                              child: TimerBuilder.scheduled([alert],
                                  builder: (context) {
                                var now = DateTime.now();
                                var reached = now.compareTo(alert) >= 0;

                                resendCode = !reached ? true : false;

                                return Padding(
                                  padding: EdgeInsets.all(7.0),
                                  child: !reached
                                      ? TimerBuilder.periodic(
                                          Duration(seconds: 1),
                                          alignment: Duration.zero,
                                          builder: (context) {
                                          var now = DateTime.now();
                                          var remaining = alert.difference(now);
                                          return Text(
                                            formatDuration(remaining),
                                          );
                                        })
                                      : Text(
                                          "00:00",
                                        ),
                                );
                              }),
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

String formatDuration(Duration d) {
  String f(int n) {
    return n.toString().padLeft(2, '0');
  }

  d += Duration(microseconds: 999999);
  return "${f(d.inMinutes)}:${f(d.inSeconds % 60)}";
}
