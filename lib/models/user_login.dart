import 'package:flutter/foundation.dart';

class UserLogin {
  final String message;
  final String token;
  final dynamic user;

  UserLogin({
    required this.message,
    required this.token,
    required this.user,
  });

  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(
      message: json['message'],
      token: json['token'],
      user: json['user'],
    );
  }
}