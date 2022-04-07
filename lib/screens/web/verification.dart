import 'package:flutter/material.dart';
import 'components/activation_code_body.dart';
import 'components/app_bar_for_web.dart';

class VerificationScreenWeb extends StatefulWidget {
  const VerificationScreenWeb({Key? key}) : super(key: key);

  @override
  State<VerificationScreenWeb> createState() => _VerificationScreenWebState();
}

class _VerificationScreenWebState extends State<VerificationScreenWeb> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarForWeb(size: size),
      body: const SingleChildScrollView(
        child: DesktopActivationCodeBody(),
      ),
    );
  }
}
