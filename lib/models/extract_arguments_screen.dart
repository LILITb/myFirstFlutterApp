import "package:flutter/material.dart";

class ScreenArguments {
  Future<String> choosenLocale;
  final String email;
  ScreenArguments(this.choosenLocale, {this.email = ""});
}
