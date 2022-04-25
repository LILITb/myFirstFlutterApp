import 'package:flutter/material.dart';

import '../../../localization/language_constants.dart';

class StepButton extends StatefulWidget {
  const StepButton({
    Key? key,
    required this.onSubmit,
    required this.backgroundColor,
    required this.textColor,
    required this.text,
    this.rightMargin = 0.0,
    this.doneForSubmitted = true,
    this.screenName = 'forAll',
  }) : super(key: key);
  final Function onSubmit;
  final Color backgroundColor;
  final Color textColor;
  final String text;
  final double rightMargin;
  final bool doneForSubmitted;
  final String screenName;
  @override
  State<StepButton> createState() => _StepButtonState();
}

class _StepButtonState extends State<StepButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: widget.rightMargin),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: ElevatedButton(
          child: Text(
            getTranslated(context, widget.text),
            style: TextStyle(color: widget.textColor),
          ),
          onPressed: () => widget.onSubmit(),
          style: ElevatedButton.styleFrom(
              primary: widget.backgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              textStyle: TextStyle(
                  color: widget.textColor,
                  fontSize: 16,
                  height: 2.1,
                  letterSpacing: 0.02,
                  fontWeight: FontWeight.w700)),
        ),
      ),
    );
  }
}
