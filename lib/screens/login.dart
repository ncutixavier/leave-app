import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:leaveapp/screens/leave.dart';
import 'package:leaveapp/screens/register.dart';
import 'package:leaveapp/services/http-service.dart';
import 'package:leaveapp/models/user_login.dart';
import 'package:leaveapp/services/user_service.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);
  static const routename = "login";

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  final GlobalKey<FormState> loginformkey = GlobalKey();
  final HttpService httpService = HttpService();
  final UserService userService = UserService();

  String? email = "";
  String? password = "";
  bool show = false;
  bool isLoading = false;

  Future<UserLogin>? _futureUserLoggedIn;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: loginformkey,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("images/logo_dark.png"),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    "Welcome to Leave Management System",
                    style: TextStyle(fontFamily: "Inter-Bold", fontSize: 15.0),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 35.0),
                    child: Row(children: const [
                      Expanded(
                          child: Divider(
                        endIndent: 10.0,
                        thickness: 1,
                      )),
                      Text(
                        "Log in",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Expanded(
                          child: Divider(
                        indent: 10.0,
                        thickness: 1,
                      )),
                    ]),
                  ),
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
                        if (value == null || value.isEmpty) {
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
                    height: 80.0,
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !show,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Enter your password ',
                        border: const OutlineInputBorder(),
                        labelText: 'Password',
                        suffixIcon: show
                            ? InkWell(
                                child: const Icon(
                                  Icons.visibility_outlined,
                                  size: 20,
                                  color: Color(0xff6B6565),
                                ),
                                onTap: () {
                                  setState(() {
                                    show = !show;
                                  });
                                },
                              )
                            : InkWell(
                                child: const Icon(
                                  Icons.visibility_off_outlined,
                                  size: 20,
                                  color: Color(0xff6B6565),
                                ),
                                onTap: () {
                                  setState(() {
                                    show = !show;
                                  });
                                },
                              ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is required";
                        }
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
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xff638FFF))),
                      onPressed: (email!.isEmpty || password!.isEmpty)
                          ? null
                          : () {
                              if (loginformkey.currentState!.validate()) {
                                Navigator.of(context)
                                    .pushNamed(Leave_Screen.routename);
                                print('email: $email -- password: $password');
                                setState(() {
                                  isLoading = true;
                                });
                                // setState(() {
                                //   _futureUserLoggedIn =
                                //       userService.login('$email', '$password');
                                // });
                              }
                            },
                      child: isLoading
                          ? const SizedBox(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
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
                  SizedBox(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Not yet registered? ",
                          style: TextStyle(fontSize: 16),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(Register_Screen.routename);
                          },
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                                color: Color(0xff638FFF),
                                decoration: TextDecoration.underline,
                                fontSize: 16),
                          ),
                        )
                      ],
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
                  ),
                  SizedBox(
                    height: 50,
                    child: _futureUserLoggedIn == null
                        ? Text("")
                        : FutureBuilder<UserLogin>(
                            future: _futureUserLoggedIn,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                WidgetsBinding.instance!
                                    .addPostFrameCallback((_) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                });

                                return Text(snapshot.data!.message);
                              } else if (snapshot.hasError) {
                                WidgetsBinding.instance!
                                    .addPostFrameCallback((_) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
                                return Text("${snapshot.error}");
                              }

                              return const Text("");
                            }),
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
