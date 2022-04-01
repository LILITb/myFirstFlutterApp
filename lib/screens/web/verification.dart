import 'package:flutter/material.dart';
import 'package:hyid/classes/language.dart';
import 'package:hyid/localization/language_constants.dart';
import 'package:hyid/screens/web/components/body3.dart';
import 'package:universal_io/io.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'components/app_bar_for_web.dart';
import 'components/language_dropdown.dart';

class VerificationScreenWeb extends StatefulWidget {
  const VerificationScreenWeb({Key? key}) : super(key: key);

  @override
  State<VerificationScreenWeb> createState() => _VerificationScreenWebState();
}

class _VerificationScreenWebState extends State<VerificationScreenWeb> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // ignore: prefer_const_constructors
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarForWeb(size: size),
      body: SingleChildScrollView(
        child: DesktopBody3(),
      ),
    );
  }
}
