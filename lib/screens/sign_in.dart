import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leaveapp/widgets/header.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  static const routeName = "sign-in";
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String email = "";
  String password = "";
  bool show = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Header(),
            Expanded(
              child: Container(),
            ),
            Positioned(
              top: 180,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: height * 0.52,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: ListView(
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 35.0,
                          fontFamily: "Inter-Regular",
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    const Text(
                      "Sign in to continue",
                      style: TextStyle(
                          fontFamily: "Inter-Regular",
                          color: Color(0xff888888),
                          fontSize: 16),
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Form(
                      key: _formKey,
                      child: SizedBox(
                        height: height * 0.4,
                        child: ListView(
                          children: [
                            SizedBox(
                              height: 45.0,
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  isDense: true,
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.only(
                                        left: 10), // add padding to adjust icon
                                    child: Icon(Icons.email_outlined),
                                  ),
                                  hintText: 'Enter your email',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                    borderSide: const BorderSide(
                                      color: Color(0xffC4C4C4),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFFAD0B63),
                                    ),
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                  border: const OutlineInputBorder(),
                                  hintStyle: const TextStyle(
                                    color: Color(0xff9099A6),
                                    fontFamily: 'Inter-Regular',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    email = value;
                                  });
                                },
                                validator: (value) {
                                  if (GetUtils.isEmail(value!)) {
                                    return null;
                                  }
                                  return 'Please enter a valid Email';
                                },
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            SizedBox(
                              height: 45.0,
                              child: TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: !show,
                                decoration: InputDecoration(
                                  isDense: true,
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.only(
                                        left: 10), // add padding to adjust icon
                                    child: Icon(Icons.password_outlined),
                                  ),
                                  hintText: 'Enter your password ',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                    borderSide: const BorderSide(
                                      color: Color(0xffC4C4C4),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFFAD0B63),
                                    ),
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                  border: const OutlineInputBorder(),
                                  hintStyle: const TextStyle(
                                    color: Color(0xff9099A6),
                                    fontFamily: 'Inter-Regular',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                  ),
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
                              height: height * 0.015,
                            ),
                            SizedBox(
                              height: height * 0.03,
                              width: double.infinity,
                              child: InkWell(
                                onTap: () {
                                  // Navigator.of(context).pushNamed(ForgotPassword.routename);
                                },
                                child: const Text(
                                  "Forgot Password",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: Color(0xFFAD0B63),
                                      decoration: TextDecoration.underline,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.015,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(15),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                    const Color(0xFFAD0B63),
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                    ),
                                  ),
                                ),
                                onPressed: null,
                                child: const Text("Sign in"),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.07,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Not yet registered? ",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Navigator.of(context)
                                      //     .pushNamed(Register_Screen.routename);
                                    },
                                    child: const Text(
                                      "Sign up",
                                      style: TextStyle(
                                        color: Color(0xFFAD0B63),
                                        decoration: TextDecoration.underline,
                                        fontSize: 16,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
