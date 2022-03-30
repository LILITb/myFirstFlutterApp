import 'package:flutter/material.dart';

class DesktopSide extends StatelessWidget {
  const DesktopSide({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.187,
      height: size.height,
      color: const Color.fromRGBO(66, 63, 246, 1),
      child: Text('left side'),
      // Image.asset("assets/images/desktopSide.png", fit: BoxFit.fill
      // width: size.width * 0.09,
      //height: size.height * 0.9,
      //),
    );
  }
}
