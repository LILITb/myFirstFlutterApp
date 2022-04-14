import 'package:flutter/material.dart';
import '../../../localization/language_constants.dart';

class RightSideTitle extends StatelessWidget {
  const RightSideTitle({
    Key? key,
    required this.size,
    required this.title,
  }) : super(key: key);

  final Size size;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(top: size.height * 0.18, right: size.width * 0.15),
      width: size.width * 0.3,
      height: size.height * 0.08,
      child: Center(
        child: Text(
          getTranslated(context, title),
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
