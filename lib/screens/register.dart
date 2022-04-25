import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:leaveapp/models/user_register.dart';
import 'package:leaveapp/screens/leave.dart';
import 'package:leaveapp/screens/login.dart';
import 'package:leaveapp/models/department.dart';
import 'package:http/http.dart' as http;
import 'package:leaveapp/services/department-service.dart';
import 'package:leaveapp/models/department.dart';
import 'package:leaveapp/services/user_service.dart';
import 'package:another_flushbar/flushbar.dart';

class Register_Screen extends StatefulWidget {
  const Register_Screen({Key? key}) : super(key: key);
  static const routename = "register";

  @override
  State<Register_Screen> createState() => _Register_ScreenState();
}

class _Register_ScreenState extends State<Register_Screen> {
  final GlobalKey<FormState> registerformkey = GlobalKey();
  final DepartmentService httpService = DepartmentService();
  final UserService userService = UserService();

  String? email = "";
  String? password = "";
  String? department = "";
  String? full_name = "";
  String? errorMessage;
  bool show = false;
  bool isloading = false;

  Future<UserRegister>? _futureUserRegister;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: registerformkey,
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
                        "Register",
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
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: 'Enter your full name ',
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                      onChanged: (value) {
                        setState(() {
                          full_name = value;
                        });
                      },
                      validator: (value) {
                        // Check if this field is empty
                        if (value == null || value.isEmpty) {
                          return 'Name is required';
                        }
                        return null;
                      },
                    ),
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
                  Container(
                    height: 55.0,
                    margin: EdgeInsets.only(bottom: 20.0),
                    child: FutureBuilder(
                      future: httpService.getDepartments(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Department>> snapshot) {
                        if (snapshot.hasData) {
                          List<Department>? posts = snapshot.data;
                          Iterable<String> all_departments = posts!
                              .map((Department post) => post.departmentName);
                          return DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                                isDense: true,
                                border: OutlineInputBorder(),
                                labelText: "Department"),
                            items: all_departments.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text('${value} Department'),
                              );
                            }).toList(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Department is required';
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                department = value;
                              });
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error:: ${snapshot.error}');
                        } else {
                          return SizedBox(
                            height: 55.0,
                            width: double.infinity,
                            child: Container(
                              padding: EdgeInsets.only(top: 18.0),
                              decoration: BoxDecoration(
                                color: Color(0xffE5EBFC),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                border: Border.all(
                                  color: Colors.black26, // red as border color
                                ),
                              ),
                              child: Text(
                                "Loading department...",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 17.0),
                              ),
                            ),
                          );
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
                      onPressed: (email!.isEmpty ||
                              password!.isEmpty ||
                              full_name!.isEmpty ||
                              department!.isEmpty)
                          ? null
                          : () {
                              if (registerformkey.currentState!.validate()) {
                                setState(() {
                                  isloading = true;
                                });
                                  userService
                                      .register('$email', '$password',
                                          '$full_name', '$department')
                                      .then((value) {
                                    setState(() {
                                      isloading = false;
                                    });
                                    Navigator.of(context)
                                        .pushNamed(Login_Screen.routename);
                                  }).catchError((error) {
                                    setState(() {
                                      isloading = false;
                                    });
                                    Map msg = jsonDecode(error.message);
                                    Flushbar(
                                      message: msg['message'],
                                      backgroundColor: Color(0xffFAE8EB),
                                      duration: Duration(seconds: 3),
                                      messageColor: Colors.redAccent,
                                      messageSize: 15.0,
                                      icon: Icon(
                                        Icons.error,
                                        color: Colors.redAccent,
                                      ),
                                    ).show(context);
                                  });
                              }
                            },
                      child: isloading
                          ? const SizedBox(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                              height: 20.0,
                              width: 20.0,
                            )
                          : const Text(
                              'Sign up',
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
                          "Already have an account? ",
                          style: TextStyle(fontSize: 16),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(Login_Screen.routename);
                          },
                          child: const Text(
                            "Sign in",
                            style: TextStyle(
                                color: Color(0xff638FFF),
                                decoration: TextDecoration.underline,
                                fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
