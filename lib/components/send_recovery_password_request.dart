import 'dart:convert';
import "package:http/http.dart" as http;

Future<http.Response> sendCodeToEmailForForgotPassword(
    String email, String locale) async {
  Map data = {
    'link':
        'https://development.connectto.com/hyeid-new/ru/auth/change-password"',
    'locale': locale,
    'email': email,
  };
  print(data.toString());

  final response = await http.patch(
    Uri.parse(
        'https://development.connectto.com:8085/hyeid-back/v2/user/forgot-password'),
    headers: {"Accept": "*/*", "Content-Type": "application/json"},
    body: json.encode(data),
  );

  // Map<String, String> passingData = {
  //   "email": email,
  //   "link":
  //       "https://development.connectto.com/hyeid-new/en/auth/verify-account",
  //   "locale": "en"
  // };
  print(response.toString());
  return response;
}
