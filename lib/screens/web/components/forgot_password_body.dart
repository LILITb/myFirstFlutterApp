import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import '../../../constants.dart';
import '../../../localization/language_constants.dart';
import 'right_side_form_wrapper.dart';
import 'right_side_title.dart';

import 'step_button.dart';
import 'template_for_web.dart';
import 'text_form_field.dart';

import '../../../components/send_recovery_password_request.dart';

class WebForgotPasswordBody extends StatefulWidget {
  const WebForgotPasswordBody({
    Key? key,
  }) : super(key: key);

  @override
  State<WebForgotPasswordBody> createState() => _WebForgotPasswordBodyState();
}

class _WebForgotPasswordBodyState extends State<WebForgotPasswordBody> {
  bool checked = false;

  final _formKey = GlobalKey<FormState>();

  final email = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    email.dispose();
  }

  void onSubmit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    print('click succeed');

    http.Response response =
        await sendCodeToEmailForForgotPassword(email.text, 'en');
    if (response.statusCode == 200) {
      Map<String, String> passingData = {
        "email": email.text,
        "locale": "en",
        "link":
            "https://development.connectto.com/hyeid-new/ru/auth/change-password"
      };
      Navigator.pushReplacementNamed(context, "/change-password",
          arguments: passingData);
      // } else {
      //   print('get an error ${response.body["message"].toString()}');
      // }
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

    Size size = MediaQuery.of(context).size;

    return TemplateForWeb(
      formKey: _formKey,
      child: Column(
        children: [
          RightSideTitle(size: size, title: "recover_password"),
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
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: getTranslated(
                            context, 'recover_password_enter_email'),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ]),
                  ),
                  const SizedBox(height: 14),
                  const Divider(
                    color: Color.fromRGBO(34, 33, 32, 0.25),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  TextFormWidget(
                    controller: email,
                    name: 'email',
                    validateFunction: emailValdiate,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Container(
            margin: EdgeInsets.only(top: 0, right: size.width * 0.15),
            width: size.width * 0.3,
            height: size.height * 0.08,
            child: Row(
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
                  height: 8,
                ),
                StepButton(
                    onSubmit: onSubmit,
                    backgroundColor: kPrimaryColor,
                    text: 'recover',
                    textColor: Colors.white),
                SizedBox(
                  width: size.width * 0.025,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
