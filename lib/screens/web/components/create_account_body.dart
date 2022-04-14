import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../localization/language_constants.dart';
import 'right_side_form_wrapper.dart';
import 'right_side_title.dart';
import 'password_text_field.dart';
import 'step_button.dart';
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

  String passwordValue = "";
  String confirmPasswordValue = "";

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
    dynamic emailValdiate(value) {
      if (value!.isEmpty) {
        return getTranslated(context, 'required');
      }
      if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value)) {
        return 'Enter a valid email!';
      }
      return null;
    }

    dynamic nameValdiate(String? value) {
      if (value!.isEmpty) {
        return getTranslated(context, 'required');
      }
      if (value.length < 3 || value.length > 20) {
        return getTranslated(context, 'enter_valid_value');
      }
      if (!RegExp(r"[a-zA-Z -\']").hasMatch(value)) {
        return getTranslated(context, 'enter_valid_value');
      }
      return null;
    }

    dynamic surnameValdiate(String? value) {
      if (value!.isEmpty) {
        return getTranslated(context, 'required');
      }
      if (value.length < 3 || value.length > 23) {
        return getTranslated(context, 'enter_valid_value');
      }
      if (!RegExp(r"[a-zA-Z-\']").hasMatch(value)) {
        return getTranslated(context, 'enter_valid_value');
      }
      return null;
    }

    dynamic passwordValdiate(String? value) {
      if (value!.isEmpty) {
        return getTranslated(context, 'required');
      }
      if (value.length < 8) return getTranslated(context, 'enter_valid_value');
      if (value.contains(RegExp(r"[+ ]"))) {
        return getTranslated(context, 'enter_valid_value');
      }

      if (!value.contains(RegExp(r"[a-z]"))) {
        return getTranslated(context, 'enter_valid_value');
      }
      if (!value.contains(RegExp(r"[A-Z]"))) {
        return getTranslated(context, 'enter_valid_value');
      }
      if (!value.contains(RegExp(r"[0-9]"))) {
        return getTranslated(context, 'enter_valid_value');
      }
      if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        return getTranslated(context, 'enter_valid_value');
      }
      return null;
    }

    dynamic confirmPasswordValidate(String? value) {
      return value!.isEmpty || value != passwordValue
          ? getTranslated(context, 'passord_mutch')
          : null;
    }

    Size size = MediaQuery.of(context).size;

    return TemplateForWeb(
      formKey: _formKey,
      child: Column(
        children: [
          RightSideTitle(size: size, title: "new_account"),
          RightFormWrapper(
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
                    validateFunction: nameValdiate,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormWidget(
                    controller: lastName,
                    name: 'last_name',
                    validateFunction: surnameValdiate,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormWidget(
                    controller: email,
                    name: 'email',
                    validateFunction: emailValdiate,
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
                    ValidateField: passwordValdiate,
                    onChanged: (value) => passwordValue = value,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  PasswordTextField(
                    controller: confirmPassword,
                    name: 'confirm_password',
                    ValidateField: confirmPasswordValidate,
                    onChanged: () {},
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
        ],
      ),
    );
  }
}
