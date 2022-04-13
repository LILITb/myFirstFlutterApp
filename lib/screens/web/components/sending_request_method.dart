import 'package:flutter/material.dart';
import 'dart:convert';
import "package:http/http.dart" as http;

Future signup(firstName, lastName, email, phoneNumber, countryCode, password,
    confirmPassword) async {
  Map data = {
    'crateAccountLink':
        'https://development.connectto.com/hyeid-new/en/auth/registration',
    'link':
        'https://development.connectto.com/hyeid-new/en/auth/verify-account',
    'locale': 'en',
    'email': email,
    'name': firstName,
    'password': password,
    'passwordConfirmation': confirmPassword,
    'phone': phoneNumber,
    'phoneCode': countryCode,
    'surname': lastName,
    'referralMediaToken': null,
    'token': null
  };
  print(data.toString());

  try {
    final response = await http.post(
      Uri.parse('https://development.connectto.com:8085/hyeid-back/v2/user'),
      headers: {"Accept": "*/*", "Content-Type": "application/json"},
      body: json.encode(data),
    );

    Map<String, String> passingData = {
      "email": email,
      "link":
          "https://development.connectto.com/hyeid-new/en/auth/verify-account",
      "locale": "en"
    };
    print(response.toString());
    return response;
  } catch (e) {
    print(e);
  }
}
