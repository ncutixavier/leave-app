import 'dart:async';
import 'package:flutter/material.dart';
import 'package:leaveapp/screens/login.dart';

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
    ), ()=>Navigator.of(context).pushNamed(Login_Screen.routename));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff638FFF),
      body: Container(
        color: Color(0xff638FFF),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/logo_light.png")
          ],
        ),
      ),
    );
  }
}

