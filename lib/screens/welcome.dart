import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leaveapp/screens/sign_in.dart';
import 'package:leaveapp/widgets/header.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);
  static const routeName = "welcome";
  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: SafeArea(
          child: Column(
            children: [
              const Header(),
              SizedBox(
                height: height * 0.1,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                width: double.infinity,
                child: FlatButton(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  color: const Color(0xFFAD0B63),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(SignIn.routeName);
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 30.0),
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    side: const BorderSide(
                      width: 1.0,
                      color: Color(0xFFAD0B63),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.035,
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  "Welcome again!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFFAD0B63),
                      fontSize: 40.0,
                      fontFamily: "Italianno-Regular"),
                ),
              )
            ],
          ),
        ));
  }
}
