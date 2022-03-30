import 'package:flutter/material.dart';
import 'package:hyid/screens/web/components/desktopSide.dart';

import 'package:hyid/classes/language.dart';
import 'package:hyid/localization/language_constants.dart';
import 'package:hyid/main.dart';
import 'package:hyid/screens/web/components/template_for_web.dart';
import 'package:hyid/screens/web/components/text_form_field.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class Password_text_field extends StatefulWidget {
  final Function onChanged;
  final Function ValidateField;
  final String name;
  final TextEditingController controller;
  const Password_text_field({
    Key? key,
    required this.onChanged,
    required this.ValidateField,
    required this.name,
    required this.controller,
  }) : super(key: key);
  void onChangeFunction() {}
  @override
  State<Password_text_field> createState() => _Password_text_fieldState();
}

class _Password_text_fieldState extends State<Password_text_field> {
  bool _isHidden = true;
  @override
  Widget build(BuildContext context) { 
    return TextFormField(
      controller: widget.controller,
      obscureText: _isHidden,
      style: const TextStyle(
        color: Color.fromRGBO(34, 33, 32, 0.4),
      ),
      autofocus: true,
      onChanged: (val) {},
      decoration: InputDecoration(
        suffix: InkWell(
          onTap: () {
            setState(() {
              _isHidden = !_isHidden;
            });
          },
          child: Icon(
            _isHidden ? Icons.visibility : Icons.visibility_off,
            color: Color.fromRGBO(34, 33, 32, 0.5),
          ),
        ),
        errorBorder: InputBorder.none,
        errorStyle: const TextStyle(
          color: Color.fromRGBO(255, 125, 100, 1),
        ),
        fillColor: const Color.fromRGBO(250, 250, 247, 1),
        filled: true,
        contentPadding: const EdgeInsets.all(10.0),
        labelText: getTranslated(context, 'password'),
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
      validator: (value) => widget.ValidateField(value),
    );
  }
}
