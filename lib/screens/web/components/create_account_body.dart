import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import '../../../classes/language.dart';
import '../../../localization/language_constants.dart';
import '../../../main.dart';
import 'password_text_field.dart';
import 'template_for_web.dart';
import 'text_form_field.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class DesktopCreateAccountBody extends StatefulWidget {
  const DesktopCreateAccountBody({
    Key? key,
  }) : super(key: key);

  @override
  State<DesktopCreateAccountBody> createState() =>
      _DesktopCreateAccountBodyState();
}

class _DesktopCreateAccountBodyState extends State<DesktopCreateAccountBody> {
  bool checked = false;
  String phoneNumber = " ";
  String countryCode = " ";
  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  final _formKey = GlobalKey<FormState>();
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

      try {
        final response = await http.post(
          Uri.parse(
              'https://development.connectto.com:8085/hyeid-back/v2/user'),
          headers: {"Accept": "*/*", "Content-Type": "application/json"},
          body: json.encode(data),
        );

        Map<String, String> passingData = {
          "email": email,
          "link":
              "https://development.connectto.com/hyeid-new/en/auth/verify-account",
          "locale": "en"
        };
        if (response.statusCode == 200) {
          print('created');
          Navigator.pushReplacementNamed(context, "/verification",
              arguments: passingData);
        }
      } catch (e) {
        print(e);
      }
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
            padding: EdgeInsets.fromLTRB(
                size.width * 0.025, 0, size.width * 0.025, 0),
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
                              decoration: const InputDecoration(
                                labelText: 'Phone Number',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                              ),
                              initialCountryCode: 'US',
                              onChanged: (phone) {
                                phoneNumber = phone.number;
                                countryCode = phone.countryCode;
                              },
                            )),
                        const SizedBox(
                          height: 15,
                        ),
                        PasswordTextField(
                          controller: password,
                          name: 'Password',
                          ValidateField: validateFunc,
                          onChanged: onChangeField,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        PasswordTextField(
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
                              margin: const EdgeInsets.only(right: 15),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: ElevatedButton(
                                  child: Text(
                                    getTranslated(context, 'cancel'),
                                    style: const TextStyle(
                                      color: Color.fromRGBO(
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
                                          color: Color.fromRGBO(
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
                            const SizedBox(
                              height: 35,
                            ),
                            Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: ElevatedButton(
                                  child: Text(
                                    getTranslated(context, 'create'),
                                    style: const TextStyle(color: Colors.white),
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
                        const SizedBox(
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
