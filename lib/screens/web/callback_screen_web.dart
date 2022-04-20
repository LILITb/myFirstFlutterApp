import 'package:flutter/material.dart';

class CallbackScreenWeb extends StatefulWidget {
  const CallbackScreenWeb({Key? key}) : super(key: key);

  @override
  State<CallbackScreenWeb> createState() => _CallbackScreenWebState();
}

class _CallbackScreenWebState extends State<CallbackScreenWeb> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('callback'),
    );
  }
}
