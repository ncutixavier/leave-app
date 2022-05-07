import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:leaveapp/screens/leave.dart';
import 'package:leaveapp/screens/register.dart';
import 'package:leaveapp/services/department-service.dart';
import 'package:leaveapp/models/user_login.dart';
import 'package:leaveapp/services/user_service.dart';
import 'package:another_flushbar/flushbar.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);
  static const routename = "forgot-password";
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> forgotPasswordformkey = GlobalKey();
  String email = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("images/logo_dark.png"),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  "Leave Management System",
                  style: TextStyle(fontFamily: "Inter-Bold", fontSize: 15.0),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 35.0),
                  child: Row(children: const [
                    Expanded(
                        child: Divider(
                          endIndent: 10.0,
                          thickness: 1,
                        )),
                    Text(
                      "Forgot Passsword",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Expanded(
                        child: Divider(
                          indent: 10.0,
                          thickness: 1,
                        )),
                  ]),
                ),
                Form(
                  key: forgotPasswordformkey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 80.0,
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              isDense: true,
                              hintText: 'Enter your email ',
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                            ),
                            onChanged: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                            validator: (value) {
                              // Check if this field is empty
                              if (value!.isEmpty) {
                                return 'Email is required';
                              }

                              // using regular expression
                              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                return "Please enter a valid email address";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(15),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xff638FFF))),
                            onPressed: null,
                            child: isLoading
                                ? const SizedBox(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                              ),
                              height: 20.0,
                              width: 20.0,
                            )
                                : const Text(
                              'Sign In',
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: InkWell(
                    onTap: () {},
                    child: const Text(
                      "Forgot Password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff638FFF),
                          decoration: TextDecoration.underline,
                          fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );;
  }
}
