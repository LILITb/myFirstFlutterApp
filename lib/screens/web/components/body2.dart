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
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hyid/hyeid_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DesktopBody2 extends StatefulWidget {
  const DesktopBody2({
    Key? key,
  }) : super(key: key);

  @override
  State<DesktopBody2> createState() => _DesktopBody2State();
}

class _DesktopBody2State extends State<DesktopBody2> {
  bool checked = false;
  String phoneNumber = " ";
  String countryCode = " ";
  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
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

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final phone = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    firstName.dispose();
    lastName.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    phone.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future signup(
        {firstName,
        lastName,
        email,
        phone,
        countryCode,
        password,
        confirmPassword}) async {
      Map data = {
        'crateAccountLink':
            'https://development.connectto.com/hyeid-new/en/auth/registration',
        'link':
            'https://development.connectto.com/hyeid-new/en/auth/verify-account',
        'locale': 'en',
        'email': email,
        'name': firstName,
        'password': password,
        'passwordConfirmation': confirmPassword,
        'phone': phone,
        'phoneCode': countryCode,
        'surname': lastName,
        'referralMediaToken': null,
        'token': null
      };
      print(data.toString());

      try {
        final response = await http.post(
          Uri.parse(
              'https://development.connectto.com:8085/hyeid-back/v2/user'),
          headers: {"Accept": "*/*", "Content-Type": "application/json"},
          body: json.encode(data),
        );

        print(response.statusCode);
        if (response.statusCode == 200) {
          print('created');
          Navigator.pushReplacementNamed(context, "/verification");
          //        Navigator.pushNamed(
          //   context,
          //   ScreenArguments.routeName,
          //   arguments: ScreenArguments(
          //     'Extract Arguments Screen',
          //     'This message is extracted in the build method.',
          //   ),
          // );
        }
      } catch (e) {
        print('get an error');
        print(e);
      }

      // if (response.statusCode == 200) {
      //   setState(() {
      //     isLoading = false;
      //     print(response);
      //   });
      //   Map<String, dynamic> resposne = jsonDecode(response.body);
      //   if (!resposne['error']) {
      //     Map<String, dynamic> user = resposne['data'];
      //     print(" User name ${user['data']}");
      //     savePref(1, user['name'], user['email'], user['id']);
      //     Navigator.pushReplacementNamed(context, "/");
      //   } else {
      //     print(" ${resposne['message']}");
      //   }
      //   // scaffoldMessenger
      //   //     .showSnackBar(SnackBar(content: Text("${resposne['message']}")));
      // } else {
      //   print(response.statusCode);
      //   print(response);
      //   print('cant create account');
      //   // scaffoldMessenger
      //   //     .showSnackBar(SnackBar(content: Text("Please Try again")));
      // }
    }

    dynamic validateFunc(value) {
      if (value!.isEmpty) {
        return getTranslated(context, 'required');
      }
      return null;
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
                getTranslated(context, 'new_account'),
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
                Container(
                  width: size.width * 0.7,
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: size.height * 0.05),
                        TextFormWidget(
                          controller: firstName,
                          name: 'first_name',
                          validateFunction: validateFunc,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormWidget(
                          controller: lastName,
                          name: 'last_name',
                          validateFunction: validateFunc,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormWidget(
                          controller: email,
                          name: 'email',
                          validateFunction: validateFunc,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                            width: size.width * 0.3,
                            child: IntlPhoneField(
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                              ),
                              initialCountryCode: 'US',
                              onChanged: (phone) {
                                print(phone.toString());
                                print(phone.completeNumber);
                                phoneNumber = phone.number;
                                countryCode = phone.countryCode;
                                print('${countryCode}, ,${phoneNumber}');
                              },
                            )),
                        const SizedBox(
                          height: 15,
                        ),
                        Password_text_field(
                          controller: password,
                          name: 'Password',
                          ValidateField: validateFunc,
                          onChanged: onChangeField,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Password_text_field(
                          controller: confirmPassword,
                          name: 'confirm_password',
                          ValidateField: validateFunc,
                          onChanged: onChangeField,
                        ),
                        const SizedBox(
                          height: 62,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 15),
                              // alignment: Alignment.topRight,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: ElevatedButton(
                                  child: Text(
                                    getTranslated(context, 'cancel'),
                                    style: TextStyle(
                                      color: const Color.fromRGBO(
                                        59,
                                        158,
                                        146,
                                        1,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    final isValid =
                                        _formKey.currentState!.validate();
                                    if (!isValid) {
                                      return;
                                    }
                                    Navigator.of(context).pushNamed('/');
                                    _formKey.currentState!.save();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: const Color.fromRGBO(
                                          255, 255, 255, 1),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 14),
                                      textStyle: const TextStyle(
                                          color: const Color.fromRGBO(
                                            59,
                                            158,
                                            146,
                                            1,
                                          ),
                                          fontSize: 16,
                                          height: 2.1,
                                          letterSpacing: 0.02,
                                          fontWeight: FontWeight.w700)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: ElevatedButton(
                                  child: Text(
                                    getTranslated(context, 'create'),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    final isValid =
                                        _formKey.currentState!.validate();
                                    if (!isValid) {
                                      return;
                                    }
                                    _formKey.currentState!.save();
                                    signup(
                                        firstName: firstName.text,
                                        lastName: lastName.text,
                                        email: email.text,
                                        phone: phoneNumber,
                                        password: password.text,
                                        confirmPassword: confirmPassword.text,
                                        countryCode: countryCode);

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
