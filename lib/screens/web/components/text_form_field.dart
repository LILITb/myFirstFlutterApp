import 'package:flutter/material.dart';
import 'package:hyid/screens/web/components/desktopSide.dart';

import 'package:hyid/classes/language.dart';
import 'package:hyid/localization/language_constants.dart';
import 'package:hyid/main.dart';
import 'package:hyid/screens/web/components/template_for_web.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class TextFormWidget extends StatelessWidget {
  final String name;
  final Function validateFunction;
  final TextEditingController controller;
  const TextFormWidget({
    Key? key,
    required this.name,
    required this.validateFunction,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(
        color: Color.fromRGBO(34, 33, 32, 0.4),
      ),
      autofocus: true,
      onChanged: (val) {},
      decoration: InputDecoration(
        errorBorder: InputBorder.none,
        errorStyle: const TextStyle(
          color: Color.fromRGBO(255, 125, 100, 1),
        ),
        fillColor: const Color.fromRGBO(250, 250, 247, 1),
        filled: true,
        contentPadding: const EdgeInsets.all(10.0),
        labelText: getTranslated(context, name),
        labelStyle: const TextStyle(
          color: Color.fromRGBO(59, 158, 146, 1),
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        border: const OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromRGBO(59, 158, 146, 1), width: 2),
          // borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromRGBO(59, 158, 146, 1)),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      validator: (value) => validateFunction(value),
      onSaved: (String? value) {
        var name = value;
      },
    );
  }
}
