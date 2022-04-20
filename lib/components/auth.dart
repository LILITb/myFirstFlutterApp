import 'dart:convert';
import 'dart:io';

import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:webview_flutter/webview_flutter.dart';
import "package:http/http.dart" as http;

// void printWrapped(String text) {
//   final pattern = RegExp('.{400}'); // 800 is the size of each chunk
//   pattern.allMatches(text).forEach((match) => print(match.group(0)));
// }

Future<http.Response> login(String username, String pass) async {
  final authorizationEndpoint = Uri.parse(
      "https://development.connectto.com:8085/auth-hyeid/oauth/token");

  //const username = "witerey138@3dinews.com";
  //const password = "Hh1\$Hh1\$";
  const identifier = "mobile";
  const secret = "secret";

  var client = await oauth2.resourceOwnerPasswordGrant(
      authorizationEndpoint, username, pass,
      identifier: identifier, secret: secret);

  final redirectUrl =
      Uri.parse('https://development.connectto.com:8085/hyeid-back/user-info');
  //printWrapped("get response : \n" + utf8.decode(response.bodyBytes));
  final response = await client.get(
    redirectUrl,
    headers: {
      "Accept": "*/*",
      "Content-Type": "text/plain",
      //"Authorization": "bearer f546ae2d-a650-4c89-9b16-c90a28b0f771"
    },
  );
  return response;
  // if (response.statusCode == 200) {
  //   return true;
  // } else {
  //   return false;
  // }
  //final fragment = Uri.splitQueryString(Uri.parse(client.toString()).fragment);

  //final tokenEndpoint = Uri.parse(
  // 'https://development.connectto.com:8085/auth-hyeid/oauth/token');
  //final redirectUrl = Uri.parse('https://development.connectto.com/hyeid-new');
  // var grant = oauth2.AuthorizationCodeGrant(
  //     identifier, authorizationEndpoint, tokenEndpoint,
  //     secret: secret);

  // // A URL on the authorization server (authorizationEndpoint with some additional
  // // query parameters). Scopes and state can optionally be passed into this method.
  // var authorizationUrl = grant.getAuthorizationUrl(redirectUrl);
}
