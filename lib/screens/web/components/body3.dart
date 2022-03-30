import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:hyid/screens/web/components/desktopSide.dart';
import 'package:hyid/classes/language.dart';
import 'package:hyid/localization/language_constants.dart';
import 'package:hyid/main.dart';

class DesktopBody3 extends StatefulWidget {
  const DesktopBody3({
    Key? key,
  }) : super(key: key);

  @override
  State<DesktopBody3> createState() => _DesktopBody3State();
}

class _DesktopBody3State extends State<DesktopBody3> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return const Center(
      child: Text('Verification'),
    );
  }
}
