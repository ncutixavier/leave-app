import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarService {
  static displaySnackBar(String text) => Flushbar(
        message: text,
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Color(0xffFAE8EB),
        duration: Duration(seconds: 3),
        messageColor: Colors.redAccent,
        messageSize: 15.0,
        icon: Icon(
          Icons.error,
          color: Colors.redAccent,
        ),
      );
}
