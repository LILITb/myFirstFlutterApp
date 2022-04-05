import 'package:flutter/material.dart';
import 'package:hyid/models/extract_arguments_screen.dart';
import 'package:hyid/screens/web/components/desktopSide.dart';

import 'package:hyid/classes/language.dart';
import 'package:hyid/localization/language_constants.dart';
import 'package:hyid/main.dart';
import 'package:hyid/screens/web/components/password_text_field.dart';
import 'package:hyid/screens/web/components/template_for_web.dart';
import 'package:hyid/screens/web/components/text_form_field.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class DesktopBody1 extends StatefulWidget {
  const DesktopBody1({Key? key}) : super(key: key);

  @override
  State<DesktopBody1> createState() => _DesktopBody1State();
}

class _DesktopBody1State extends State<DesktopBody1> {
  bool checked = false;

  bool _isHidden = true;
  // void _togglePasswordView() {
  //   setState(() {
  //     _isHidden = !_isHidden;
  //   });
  // }

  final _formKey = GlobalKey<FormState>();
  final userName = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    userName.dispose();
    password.dispose();
  }

  // void _submit() {
  //   final isValid = _formKey.currentState!.validate();
  //   if (!isValid) {
  //     return;
  //   }
  //   Navigator.of(context).pushNamed('/password-setup');
  //   _formKey.currentState!.save();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // Future<String> getLanguageCode(BuildContext context) async {
    //   if (Localizations.localeOf(context).languageCode == null) {
    //     return Language(1, "🇺🇸", "English", "en").languageCode;
    //   } else {
    //     return Localizations.localeOf(context).languageCode;
    //   }
    // }

    // Future<String> LanguageCode = getLanguageCode(context);

    // void _changeLanguage(Language language) async {
    //   print('change language ');
    //   Locale _locale = await setLocale(language.languageCode);
    //   MyApp.setLocale(context, _locale);
    //   print('language code changed ${language.languageCode}');
    //   LanguageCode = (_locale.languageCode as Future<String>);
    //   print('locale languagecode ${LanguageCode}');
    // }

    // print('languagecode ${LanguageCode.toString()}');

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
                          controller: userName,
                          name: 'username_email',
                          validateFunction: validateFunc,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Password_text_field(
                          controller: password,
                          name: 'Password',
                          ValidateField: validateFunc,
                          onChanged: onChangeField,
                        ),
                        // TextFormField(
                        //   obscureText: _isHidden,
                        //   style: const TextStyle(
                        //     color: Color.fromRGBO(34, 33, 32, 0.4),
                        //   ),
                        //   autofocus: true,
                        //   onChanged: (val) {},
                        //   decoration: InputDecoration(
                        //     suffix: InkWell(
                        //       onTap: () {
                        //         setState(() {
                        //           _isHidden = !_isHidden;
                        //         });
                        //       },
                        //       child: Icon(
                        //         _isHidden
                        //             ? Icons.visibility
                        //             : Icons.visibility_off,
                        //         color: Color.fromRGBO(34, 33, 32, 0.5),
                        //       ),
                        //     ),
                        //     errorBorder: InputBorder.none,
                        //     errorStyle: const TextStyle(
                        //       color: Color.fromRGBO(255, 125, 100, 1),
                        //     ),
                        //     fillColor: const Color.fromRGBO(250, 250, 247, 1),
                        //     filled: true,
                        //     contentPadding: const EdgeInsets.all(10.0),
                        //     labelText: getTranslated(context, 'password'),
                        //     labelStyle: const TextStyle(
                        //       color: Color.fromRGBO(59, 158, 146, 1),
                        //       fontSize: 12,
                        //       fontWeight: FontWeight.w400,
                        //     ),
                        //     border: const OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //           color: Color.fromRGBO(59, 158, 146, 1),
                        //           width: 2),
                        //       // borderRadius: BorderRadius.circular(10),
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderSide: const BorderSide(
                        //           color: Color.fromRGBO(59, 158, 146, 1)),
                        //       borderRadius: BorderRadius.circular(4),
                        //     ),
                        //   ),
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return getTranslated(context, 'required');
                        //     }
                        //     return null;
                        //   },
                        // ),
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
                                        style: TextStyle(
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
                        SizedBox(
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
                                    style: TextStyle(color: Colors.white),
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
          SizedBox(
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
                    // const url = 'https://www.google.com';
                    // if (await canLaunch(url)) launch(url);
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
                    // arguments:
                    //   ScreenArguments(LanguageCode, email: 'lianaanja')
                  },
                  child: Text(
                    getTranslated(context, 'create'),
                    style: const TextStyle(
                      fontSize: 16,
                      height: 2.1,
                      letterSpacing: 0.02,
                      fontWeight: FontWeight.w700,
                      color: const Color.fromRGBO(
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

          // Container(
          //   margin: EdgeInsets.only(top: 60),
          //   // margin: EdgeInsets.only(
          //   //     top: size.height * 0.1, right: size.width * 0.15),
          //   width: size.width * 0.3,
          //   height: size.height * 0.08,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       Link(
          //         uri: Uri.parse('https://flatteredwithflutter.com'),
          //         builder: (_, followLink) {
          //           return ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //                 primary: Colors.white,
          //                 // padding: const EdgeInsets.symmetric(
          //                 //     horizontal: 50, vertical: 20),
          //                 textStyle: const TextStyle(
          //                     fontSize: 16,
          //                     height: 2.1,
          //                     color: Color.fromRGBO(34, 33, 32, 1),
          //                     fontWeight: FontWeight.bold)),
          //             onPressed: followLink,
          //             child: Text(
          //               getTranslated(context, 'dont_have_an_account'),
          //             ),
          //           );
          //         },
          //       ),
          //       // Link(
          //       //   uri: Uri.parse(
          //       //       'https://www.figma.com/file/AsWUIRidLpuvA6CHrucLBE/HyeID-For-Arman?node-id=1%3A1663'),
          //       //   //target: LinkTarget.self,
          //       //   builder: (context, followLink) {
          //       //     return RichText(
          //       //       text: TextSpan(children: [
          //       //         TextSpan(
          //       //           text: getTranslated(
          //       //               context, 'dont_have_an_account'),
          //       //           //   recognizer: TapGestureRecognizer()
          //       //           // ..onTap = followLink,
          //       //           style: TextStyle(
          //       //             fontSize: 16,
          //       //             height: 20.6,
          //       //             color: Colors.orange,
          //       //             decoration: TextDecoration.underline,
          //       //           ),
          //       //         ),
          //       //       ]),
          //       //     );
          //       //   },
          //       // ),
          //     ],
          //     // margin: EdgeInsets.only(
          //     //     top: size.height * 0.23, right: size.width * 0.15),
          //     // widthFactor: size.width * 0.3,
          //     // heightFactor: size.height * 0.57,
          //   ),
          // ),
        ],
      ),
    );
  }
}
