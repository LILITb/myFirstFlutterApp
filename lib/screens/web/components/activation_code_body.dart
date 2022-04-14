import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'right_side_form_wrapper.dart';
import '../../../constants.dart';
import '../../../localization/language_constants.dart';
import 'right_side_title.dart';
import 'step_button.dart';
import 'template_for_web.dart';
import 'text_form_field.dart';
import 'package:timer_builder/timer_builder.dart';

class DesktopActivationCodeBody extends StatefulWidget {
  const DesktopActivationCodeBody({
    Key? key,
  }) : super(key: key);

  @override
  State<DesktopActivationCodeBody> createState() =>
      _DesktopActivationCodeBodyState();
}

class _DesktopActivationCodeBodyState extends State<DesktopActivationCodeBody> {
  bool checked = false;

  String errorMessage = '';
  bool resendCode = true;

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

  @override
  void dispose() {
    verificationCode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // get passing datas
    final Map<String, Object> passingData =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;

    dynamic validateFunc(value) {
      if (value!.isEmpty) {
        return getTranslated(context, 'required');
      }
      return null;
    }

    Future signup({verificationCode}) async {
      try {
        Map<String, String> data = {"verificationCode": verificationCode};
        final response = await http.patch(
            Uri.parse(
                'https://development.connectto.com:8085/hyeid-back/v2/user/verify'),
            headers: {
              "Accept": "*/*",
              "Content-Type": "text/plain",
              "Authorization": "Basic bW9iaWxlOnNlY3JldA=="
            },
            body: json.encode(int.parse(verificationCode)));

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
          if (_formKey.currentState!.validate()) {
            Navigator.pushReplacementNamed(context, "/");
          } else {}
        }
      } catch (e) {
        print(e);
      }
    }

    Future ResendActivationCode() async {
      try {
        final response = await http.patch(
            Uri.parse(
                'https://development.connectto.com:8085/hyeid-back/v2/user/resend'),
            headers: {"Accept": "*/*", "Content-Type": "application/json"},
            body: json.encode(passingData));

        if (response.statusCode == 200) {
          setState(() {
            resendCode = true;
          });
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

    void onChangeField(val) {
      return;
    }

    void onSubmit() async {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) {
        return;
      }
      _formKey.currentState!.save();
      signup(
        verificationCode: verificationCode.text,
      );
    }

    Size size = MediaQuery.of(context).size;

    return TemplateForWeb(
      formKey: _formKey,
      child: Column(
        children: [
          RightSideTitle(size: size, title: "account_verification"),
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
                    getTranslated(context, "verification_text"),
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
                          height: 5,
                        ),
                        Text(
                          resendCode == true
                              ? getTranslated(context, 'resend_activation_code')
                              : '',
                          style: const TextStyle(
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
                                onTap: () async {
                                  if (resendCode) return;
                                  setState(() {
                                    alert = DateTime.now()
                                        .add(const Duration(seconds: 60));
                                  });
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 3),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromRGBO(34, 33, 32, 1),
                                    width: 1.0),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0)),
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
                                          const Duration(seconds: 1),
                                          alignment: Duration.zero,
                                          builder: (context) {
                                          var now = DateTime.now();
                                          var remaining = alert.difference(now);
                                          return Text(
                                            formatDuration(remaining),
                                          );
                                        })
                                      : const Text(
                                          "00:00",
                                        ),
                                );
                              }),
                            ),
                            StepButton(
                              onSubmit: onSubmit,
                              backgroundColor: kPrimaryColor,
                              text: 'submit',
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

String formatDuration(Duration d) {
  String f(int n) {
    return n.toString().padLeft(2, '0');
  }

  d += const Duration(microseconds: 999999);
  return "${f(d.inMinutes)}:${f(d.inSeconds % 60)}";
}
