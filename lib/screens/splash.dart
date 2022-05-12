import 'dart:async';
import 'package:flutter/material.dart';
import 'package:leaveapp/screens/login.dart';
import 'package:leaveapp/screens/sign_in.dart';
import 'package:leaveapp/screens/welcome.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  static const routename = "splash";

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(
        seconds: 3
    ), ()=>Navigator.of(context).pushNamed(Welcome.routeName));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAD0B63),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/logo.png")
          ],
        ),
      ),
    );
  }
}

