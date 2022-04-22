import "package:flutter/material.dart";

import 'components/app_bar_for_web.dart';
import 'components/change_password_body.dart';
import 'components/forgot_password_body.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarForWeb(size: size),
      body: const SingleChildScrollView(
        child: WebChangePasswordBody(),
      ),
    );
  }
}
