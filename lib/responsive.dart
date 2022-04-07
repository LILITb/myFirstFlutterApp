import 'package:flutter/material.dart';
import 'package:universal_io/io.dart';

class Responsive extends StatelessWidget {
  final Widget android;
  final Widget ios;
  final Widget web;
  final Widget smallWeb;

  const Responsive({
    required this.android,
    required this.ios,
    required this.web,
    required this.smallWeb,
  }) : super();

  static bool isAndroid(BuildContext context) => Platform.isAndroid;
  static bool isIos(BuildContext context) => Platform.isIOS;

  static bool isSmallWeb(BuildContext context) =>
      MediaQuery.of(context).size.width <= 700;

  static bool isWeb(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // If our width is more than 1100 then we consider it a desktop
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1100) {
          return web;
        }
        // If width it less then 1100 and more then 650 we consider it as tablet
        else if (constraints.maxWidth <= 700 &&
            !Platform.isAndroid &&
            !Platform.isIOS) {
          return smallWeb;
        } else if (Platform.isAndroid) {
          return android;
        } else if (Platform.isIOS) {
          return ios;
        }
        // Or less then that we called it mobile
        else {
          return web;
        }
      },
    );
  }
}
