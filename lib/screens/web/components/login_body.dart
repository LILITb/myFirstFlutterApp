import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../localization/language_constants.dart';
import '../../../screens/web/components/password_text_field.dart';
import '../../../screens/web/components/template_for_web.dart';
import '../../../screens/web/components/text_form_field.dart';
import 'package:url_launcher/link.dart';

import 'right_side_form_wrapper.dart';
import 'right_side_title.dart';
import 'step_button.dart';

class DesktopLoginBody extends StatefulWidget {
  const DesktopLoginBody({Key? key}) : super(key: key);

  @override
  State<DesktopLoginBody> createState() => _DesktopLoginBodyState();
}

class _DesktopLoginBodyState extends State<DesktopLoginBody> {
  bool checked = false;

  bool _isHidden = true;
  final _formKey = GlobalKey<FormState>();
  final userName = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    userName.dispose();
    password.dispose();
  }

  void onSubmit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    Navigator.of(context).pushNamed('/password-setup');
    _formKey.currentState!.save();
  }

  late Widget child;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    dynamic validateFunc(value) {
      if (value!.isEmpty) {
        return getTranslated(context, 'required');
      }
      return null;
    }

    void onChangeField(val) {
      return;
    }

    return TemplateForWeb(
      formKey: _formKey,
      child: Column(
        children: [
          RightSideTitle(size: size, title: "sign_in_to_your_hyeid_account"),
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
                    controller: userName,
                    name: 'username_email',
                    validateFunction: validateFunc,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  PasswordTextField(
                    controller: password,
                    name: 'Password',
                    ValidateField: validateFunc,
                    onChanged: onChangeField,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Link(
                          uri: Uri.parse(
                              'https://development.connectto.com/hyeid-stage'),
                          builder: (context, followLink) {
                            return RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text:
                                      getTranslated(context, 'forgot_password'),
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ]),
                            );
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      StepButton(
                        onSubmit: onSubmit,
                        backgroundColor: kPrimaryColor,
                        text: 'sign_in',
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 62,
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  //splashColor: Colors.black26,
                  onTap: () =>
                      Navigator.of(context).pushNamed('/create-account'),
                  child: Row(
                    children: [
                      Text(
                        getTranslated(context, 'dont_have_an_account'),
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      textStyle: const TextStyle(
                          fontSize: 16,
                          height: 2.1,
                          color: Color.fromRGBO(34, 33, 32, 1),
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      '/create-account',
                    );
                  },
                  child: Text(
                    getTranslated(context, 'create'),
                    style: const TextStyle(
                      fontSize: 16,
                      height: 2.1,
                      letterSpacing: 0.02,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(
                        59,
                        158,
                        146,
                        1,
                      ),
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
