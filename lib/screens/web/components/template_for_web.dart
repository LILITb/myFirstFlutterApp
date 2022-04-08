import 'package:flutter/material.dart';
import '../../../localization/language_constants.dart';

class TemplateForWeb extends StatelessWidget {
  const TemplateForWeb({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.child,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.27),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: size.width * 0.02),
                      Container(
                        margin: EdgeInsets.only(
                          left: size.width * 0.12,
                        ),
                        width: size.width * 0.2,
                        height: size.height * 0.2,
                        child: Image.asset(
                          "assets/images/logo_big.png",
                          width: size.width * 0.2,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: size.width * 0.4,
                    margin: EdgeInsets.only(left: size.width * 0.11),
                    child: Text(
                      getTranslated(context, 'quote'),
                      style: const TextStyle(
                          color: Color.fromRGBO(34, 33, 32, 0.7),
                          fontWeight: FontWeight.w600,
                          fontSize: 28,
                          height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(flex: 5, child: child),
          ],
        ),
      ],
    );
  }
}
