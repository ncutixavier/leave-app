import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:leaveapp/screens/leave.dart';
import 'package:leaveapp/screens/login.dart';
import 'package:leaveapp/models/department.dart';
import 'package:http/http.dart' as http;

Future<Department> fetchDepartment() async {
  final response = await http
      .get(Uri.parse('http://nx-leave-app.herokuapp.com/api/v1/departments'));

  print('RES-STATUS::' + response.statusCode.toString());

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var data = jsonDecode(response.body);
    return Department.fromJson(jsonDecode(data['departments']));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Department');
  }
}

class Register_Screen extends StatefulWidget {
  const Register_Screen({Key? key}) : super(key: key);
  static const routename = "register";

  @override
  State<Register_Screen> createState() => _Register_ScreenState();
}

class _Register_ScreenState extends State<Register_Screen> {
  final GlobalKey<FormState> registerformkey = GlobalKey();
  String? email = "";
  String? password = "";
  String? department = "";
  String? full_name = "";
  bool show = false;
  final List<String> departments = [
    "Information Technology",
    "Human Resource",
    "Finance & Procurement"
  ];

  late Future<Department> futureDepartment;

  void initState() {
    super.initState();
    futureDepartment = fetchDepartment();
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
                  SizedBox(
                    height: 80.0,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                          isDense: true,
                          border: const OutlineInputBorder(),
                          labelText: "Department"),
                      items: departments.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
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
                              if (registerformkey.currentState!.validate()) {
                                Navigator.of(context)
                                    .pushNamed(Leave_Screen.routename);
                                print('email: $email -- password: $password');
                              }
                            },
                      child: const Text(
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
