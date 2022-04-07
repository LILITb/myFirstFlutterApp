import 'package:flutter/material.dart';
import 'package:hyid/localization/language_constants.dart';

class TextFormWidget extends StatelessWidget {
  final String name;
  final Function validateFunction;
  final TextEditingController controller;
  final String labelText;
  final String errorMessage;
  const TextFormWidget(
      {Key? key,
      required this.name,
      required this.validateFunction,
      required this.controller,
      this.labelText = 'label',
      this.errorMessage = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlign:
          (labelText == 'labelText') ? TextAlign.center : TextAlign.start,
      style: const TextStyle(
        color: Color.fromRGBO(34, 33, 32, 0.4),
      ),
      //autofocus: true,
      onChanged: (val) {},
      decoration: InputDecoration(
        //errorBorder: InputBorder.,
        errorStyle: const TextStyle(
          color: Colors.red,
        ),
        fillColor: const Color.fromRGBO(250, 250, 247, 1),
        filled: true,
        contentPadding: const EdgeInsets.all(10.0),
        label: (labelText == 'labelText')
            ? Center(
                child: Text(
                  getTranslated(context, name),
                ),
              )
            : null,
        labelText:
            (labelText == 'labelText') ? null : getTranslated(context, name),
        labelStyle: TextStyle(
          color: (errorMessage.length > 0)
              ? Colors.red
              : Color.fromRGBO(59, 158, 146, 1),
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
