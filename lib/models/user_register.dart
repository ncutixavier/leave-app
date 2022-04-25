import 'package:flutter/foundation.dart';

class UserRegister {
  final String message;
  final dynamic user;

  UserRegister({
    required this.message,
    required this.user,
  });

  factory UserRegister.fromJson(Map<String, dynamic> json) {
    return UserRegister(
      message: json['message'],
      user: json['user'],
    );
  }
}