import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'password_text_field.dart';
import 'right_side_form_wrapper.dart';
import '../../../constants.dart';
import '../../../localization/language_constants.dart';
import 'right_side_title.dart';
import 'step_button.dart';
import 'template_for_web.dart';
import 'text_form_field.dart';

class WebChangePasswordBody extends StatefulWidget {
  const WebChangePasswordBody({
    Key? key,
  }) : super(key: key);

  @override
  State<WebChangePasswordBody> createState() => _WebChangePasswordBodyState();
}

class _WebChangePasswordBodyState extends State<WebChangePasswordBody> {
  bool checked = false;

  String errorMessage = '';
  bool resendCode = true;
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  //timer
  late DateTime alert;

  @override
  void initState() {
    super.initState();
    //timer
    alert = DateTime.now().add(const Duration(seconds: 60));
  }

  final _formKey = GlobalKey<FormState>();
  final verificationCode = TextEditingController();
  String passwordValue = "";
  String confirmPasswordValue = "";
  bool validate = false;

  @override
  void dispose() {
    verificationCode.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // get passing datas
    final Map<String, Object> passingData =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;

    void onChangeField() {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) {
        return;
      }

      setState(() {
        validate = true;
      });
    }

    dynamic validateFunc(value) {
      if (value!.isEmpty) {
        return getTranslated(context, 'required');
      }
      // onChangeField();

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
      //onChangeField();
      return null;
    }

    dynamic confirmPasswordValidate(String? value) {
      // onChangeField();
      return value!.isEmpty || value != passwordValue
          ? getTranslated(context, 'passord_mutch')
          : null;
    }

    Future signup(data) async {
      try {
        final response = await http.patch(
            Uri.parse(
                'https://development.connectto.com:8085/hyeid-back/v2/user/reset-password'),
            headers: {
              "Accept": "*/*",
              "Content-Type": "application/json",
              "Authorization": "Basic bW9iaWxlOnNlY3JldA=="
            },
            body: json.encode(data));

        if (response.statusCode == 200) {
          Navigator.pushReplacementNamed(context, "/");
        } else {
          Map responseBody = json.decode(response.body);

          setState(() {
            errorMessage = responseBody['error_description'].length > 0
                ? responseBody['error_description']
                : responseBody['message'].length > 0
                    ? responseBody['message']
                    : null;
          });
        }
      } catch (e) {
        print(e);
      }
    }

    Future ResendActivationCode() async {
      try {
        print(passingData.toString());
        final response = await http.patch(
            Uri.parse(
                'https://development.connectto.com:8085/hyeid-back/v2/user/forgot-password'),
            headers: {"Accept": "*/*", "Content-Type": "application/json"},
            body: json.encode(passingData));

        if (response.statusCode == 200) {
          //
        } else {
          Map responseBody = json.decode(response.body);

          setState(() {
            errorMessage = responseBody['error_description'];
          });
        }
      } catch (e) {
        print(e);
      }
    }

    void onSubmit() async {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) {
        return;
      }
      _formKey.currentState!.save();

      Map data = {
        "resetPasswordToken": verificationCode.text,
        "password": password.text,
        "passwordConfirmation": confirmPassword.text
      };
      await signup(data);
    }

    Size size = MediaQuery.of(context).size;

    return TemplateForWeb(
      formKey: _formKey,
      child: Column(
        children: [
          RightSideTitle(size: size, title: "change_password_title"),
          RightFormWrapper(
            size: size,
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.022,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: Text(
                    getTranslated(context, "cgange_password_text"),
                    style: Theme.of(context).textTheme.subtitle1,
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
                          height: 34,
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
                                onTap: () async {
                                  await ResendActivationCode();
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
                        SizedBox(
                          child: Text(
                            getTranslated(context, 'change_your_pass'),
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        const Divider(
                          color: Color.fromRGBO(34, 33, 32, 0.25),
                        ),
                        const SizedBox(
                          height: 24,
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
                          onChanged: (value) => confirmPasswordValue = value,
                        ),
                        const SizedBox(
                          height: 62,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            StepButton(
                              onSubmit: onSubmit,
                              backgroundColor: kPrimaryColor,
                              text: 'done',
                              textColor: Colors.white,
                              doneForSubmitted: validate,
                              screenName: 'changePassword',
                            ),
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
          )
        ],
      ),
    );
  }
}
