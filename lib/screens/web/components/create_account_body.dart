import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import '../../../classes/language.dart';
import '../../../constants.dart';
import '../../../localization/language_constants.dart';
import '../../../main.dart';
import 'left_side_form_wrapper.dart';
import 'left_side_title.dart';
import 'password_text_field.dart';
import 'step_button2.dart';
import 'template_for_web.dart';
import 'text_form_field.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'sending_request_method.dart';

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

  void onSubmit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    final response = await signup(firstName.text, lastName.text, email.text,
        phoneNumber, countryCode, password.text, confirmPassword.text);
    if (response.statusCode == 200) {
      Map<String, String> passingData = {
        "email": email.text,
        "link":
            "https://development.connectto.com/hyeid-new/en/auth/verify-account",
        "locale": "en"
      };
      Navigator.pushReplacementNamed(context, "/verification",
          arguments: passingData);
    } else {
      print('get an error ${response.body["message"].toString()}');
    }
  }

  void onPressedCancel() {
    Navigator.of(context).pushNamed('/');
  }

  @override
  Widget build(BuildContext context) {
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
    late Widget child;
    return TemplateForWeb(
      formKey: _formKey,
      child: Column(
        children: [
          LeftSideTitle(size: size, title: "new_account"),
          LeftFormWrapper(
            size: size,
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
                      StepButton(
                        rightMargin: 15,
                        onSubmit: onPressedCancel,
                        backgroundColor: Colors.white,
                        text: 'cancel',
                        textColor: kPrimaryColor,
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      StepButton(
                          onSubmit: onSubmit,
                          backgroundColor: kPrimaryColor,
                          text: 'create',
                          textColor: Colors.white),
                    ],
                  ),
                  const SizedBox(
                    height: 62,
                  ),
                ],
              ),
            ),
          ),
          // Container(
          //   decoration: BoxDecoration(
          //     shape: BoxShape.rectangle,
          //     boxShadow: const [
          //       BoxShadow(
          //         offset: Offset(0, 1),
          //         blurRadius: 5,
          //         color: Color.fromRGBO(0, 0, 0, 0.05),
          //       ),
          //     ],
          //     borderRadius: BorderRadius.circular(16),
          //     border: Border.all(
          //       color: const Color.fromRGBO(34, 33, 32, 0.1),
          //       style: BorderStyle.solid,
          //       width: 1.0,
          //     ),
          //     color: Colors.white,
          //   ),
          //   margin: EdgeInsets.only(top: 27, right: size.width * 0.15),
          //   width: size.width * 0.3,
          //   padding: EdgeInsets.fromLTRB(
          //       size.width * 0.025, 0, size.width * 0.025, 0),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Container(
          //         width: size.width * 0.7,
          //         child: Form(
          //           key: _formKey,
          //           autovalidateMode: AutovalidateMode.always,
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: <Widget>[
          //               SizedBox(height: size.height * 0.05),
          //               TextFormWidget(
          //                 controller: firstName,
          //                 name: 'first_name',
          //                 validateFunction: validateFunc,
          //               ),
          //               const SizedBox(
          //                 height: 15,
          //               ),
          //               TextFormWidget(
          //                 controller: lastName,
          //                 name: 'last_name',
          //                 validateFunction: validateFunc,
          //               ),
          //               const SizedBox(
          //                 height: 15,
          //               ),
          //               TextFormWidget(
          //                 controller: email,
          //                 name: 'email',
          //                 validateFunction: validateFunc,
          //               ),
          //               const SizedBox(
          //                 height: 15,
          //               ),
          //               Container(
          //                   width: size.width * 0.3,
          //                   child: IntlPhoneField(
          //                     decoration: const InputDecoration(
          //                       labelText: 'Phone Number',
          //                       border: OutlineInputBorder(
          //                         borderSide: BorderSide(),
          //                       ),
          //                     ),
          //                     initialCountryCode: 'US',
          //                     onChanged: (phone) {
          //                       phoneNumber = phone.number;
          //                       countryCode = phone.countryCode;
          //                     },
          //                   )),
          //               const SizedBox(
          //                 height: 15,
          //               ),
          //               PasswordTextField(
          //                 controller: password,
          //                 name: 'Password',
          //                 ValidateField: validateFunc,
          //                 onChanged: onChangeField,
          //               ),
          //               const SizedBox(
          //                 height: 15,
          //               ),
          //               PasswordTextField(
          //                 controller: confirmPassword,
          //                 name: 'confirm_password',
          //                 ValidateField: validateFunc,
          //                 onChanged: onChangeField,
          //               ),
          //               const SizedBox(
          //                 height: 62,
          //               ),
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.end,
          //                 children: [
          //                   StepButton(
          //                     rightMargin: 15,
          //                     onSubmit: onPressedCancel,
          //                     backgroundColor: Colors.white,
          //                     text: 'cancel',
          //                     textColor: kPrimaryColor,
          //                   ),
          //                   const SizedBox(
          //                     height: 35,
          //                   ),
          //                   StepButton(
          //                       onSubmit: onSubmit,
          //                       backgroundColor: kPrimaryColor,
          //                       text: 'create',
          //                       textColor: Colors.white),
          //                 ],
          //               ),
          //               const SizedBox(
          //                 height: 62,
          //               ),
          //             ],
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
