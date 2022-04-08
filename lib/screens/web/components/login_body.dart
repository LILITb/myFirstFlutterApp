import 'package:flutter/material.dart';
import '../../../localization/language_constants.dart';
import '../../../screens/web/components/password_text_field.dart';
import '../../../screens/web/components/template_for_web.dart';
import '../../../screens/web/components/text_form_field.dart';
import 'package:url_launcher/link.dart';

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
          Container(
            margin: EdgeInsets.only(
                top: size.height * 0.18, right: size.width * 0.15),
            width: size.width * 0.3,
            height: size.height * 0.08,
            child: Center(
              child: Text(
                getTranslated(context, 'sign_in_to_your_hyeid_account'),
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
                                //target: LinkTarget.self,
                                builder: (context, followLink) {
                                  return RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: getTranslated(
                                            context, 'forgot_password'),
                                        //   recognizer: TapGestureRecognizer()
                                        // ..onTap = followLink,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          height: 2,
                                          color: Color.fromRGBO(34, 33, 32, 1),
                                          decoration: TextDecoration.underline,
                                        ),
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
                            Container(
                              alignment: Alignment.topRight,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: ElevatedButton(
                                  child: Text(
                                    getTranslated(context, 'sign_in'),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    final isValid =
                                        _formKey.currentState!.validate();
                                    if (!isValid) {
                                      return;
                                    }
                                    Navigator.of(context)
                                        .pushNamed('/password-setup');
                                    _formKey.currentState!.save();
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
                GestureDetector(
                  child: Text(
                    getTranslated(context, 'dont_have_an_account'),
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color.fromRGBO(34, 33, 32, 1),
                    ),
                  ),
                  onTap: () async {
                    Navigator.of(context).pushNamed('/create-account');
                  },
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
