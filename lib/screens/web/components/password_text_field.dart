import 'package:flutter/material.dart';
import 'package:hyid/localization/language_constants.dart';

class PasswordTextField extends StatefulWidget {
  final Function onChanged;
  final Function ValidateField;
  final String name;
  final TextEditingController controller;
  const PasswordTextField({
    Key? key,
    required this.onChanged,
    required this.ValidateField,
    required this.name,
    required this.controller,
  }) : super(key: key);
  void onChangeFunction() {}
  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
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
      onChanged: (value) => widget.onChanged(value),
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
