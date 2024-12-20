

import 'package:flutter/material.dart';

class AuthToken {
  final String token;

  AuthToken({
    required this.token,
  });

  factory AuthToken.fromJson(Map<String, dynamic> json) {
    return AuthToken(
      token: json['token'] as String,
    );
  }

}

class AuthTokenProvider with ChangeNotifier {
  final String? parsedToken;
  AuthTokenProvider({
    required this.parsedToken,
  }){
    token = parsedToken;
  }

  String? token;

}


class ReturnAuthToken {
  final String text;
  final bool success;
  final AuthToken? authToken;

  ReturnAuthToken({
   required this.text,
    required this.success,
    required this.authToken,
  });

}