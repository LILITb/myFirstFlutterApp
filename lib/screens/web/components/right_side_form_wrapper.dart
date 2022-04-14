import 'package:flutter/material.dart';

class RightFormWrapper extends StatelessWidget {
  const RightFormWrapper({
    Key? key,
    required this.size,
    required this.child,
  }) : super(key: key);

  final Size size;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 5,
            color: Color.fromRGBO(0, 0, 0, 0.05),
          ),
        ],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color.fromRGBO(34, 33, 32, 0.1),
          style: BorderStyle.solid,
          width: 1.0,
        ),
        color: const Color.fromRGBO(255, 255, 255, 1),
      ),
      margin: EdgeInsets.only(top: 27, right: size.width * 0.15),
      width: size.width * 0.3,
      padding:
          EdgeInsets.fromLTRB(size.width * 0.025, 0, size.width * 0.025, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Container(width: size.width * 0.7, child: child)],
      ),
    );
  }
}
