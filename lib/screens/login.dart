import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:leaveapp/screens/forgot_password.dart';
import 'package:leaveapp/screens/leave.dart';
import 'package:leaveapp/screens/register.dart';
import 'package:leaveapp/services/department-service.dart';
import 'package:leaveapp/models/user_login.dart';
import 'package:leaveapp/services/google_auth_service.dart';
import 'package:leaveapp/services/snackbar_service.dart';
import 'package:leaveapp/services/upload_life_service.dart';
import 'package:leaveapp/services/user_service.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);
  static const routename = "login";

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  final GlobalKey<FormState> loginformkey = GlobalKey();
  final DepartmentService httpService = DepartmentService();
  final UserService userService = UserService();
  final GoogleAuthService googleAuthService = GoogleAuthService();

  bool select_item = false;
  File? _file;

  String? email = "";
  String? password = "";
  bool show = false;
  bool isLoading = false;

  Future<UserLogin>? _futureUserLoggedIn;

  void initState() {
    super.initState();
  }

  Future<void> pickimage() async {
    FilePickerResult? result =
    await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();

      setState(() {
        _file = files.first;
      });
      print('Img:: ${files.first}');
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Management System'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        toolbarHeight: 60.0,
        elevation: 2.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Color(0xffffffff),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child: Image.asset("images/logo_dark.png"),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Row(children: const [
                    Expanded(
                        child: Divider(
                      endIndent: 10.0,
                      thickness: 1,
                    )),
                    Text(
                      "Let's get you sign in",
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                        child: Divider(
                      indent: 10.0,
                      thickness: 1,
                    )),
                  ]),
                ),
                // Container(
                //   height: 55.0,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(8.0),
                //     color: Color(0xffEBEDEF)
                //   ),
                //   child: InkWell(
                //     onTap: () async{
                //       // final provider = Provider.of<GoogleAuthService>(context, listen: false);
                //       final res = await googleAuthService.googleLogin();
                //       print('SIGN--$res');
                //     },
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         Container(
                //           height: 20.0,
                //           width: 20.0,
                //           child: Image.asset("images/google.png"),
                //         ),
                //         Text("Sign in with google", style: TextStyle(
                //           fontWeight: FontWeight.bold,
                //           fontSize: 18.0
                //         ),)
                //       ],
                //     ),
                //   ),
                // ),
                // ElevatedButton(
                //   child: Text("Logout"),
                //   onPressed: () async{
                //     final res = await googleAuthService.logout();
                //     print("LOGOUT-$res");
                //   },
                // ),
                // SizedBox(
                //   height: 15.0,
                // ),
                Center(
                    child: InkWell(
                        onTap: () {
                          pickimage();
                        },
                        child: _file == null
                            ? Image.asset(
                          'images/take_pic.png',
                        )
                            : CircleAvatar(
                          radius: 40,
                          backgroundImage: FileImage(_file!),
                        ))),
                SizedBox(
                  height: 40.0,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.all(15),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                            Color(0xff638FFF))),
                    onPressed: () async{
                      await uploadImageToFirebase();
                    },
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
                Form(
                  key: loginformkey,
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
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xff638FFF))),
                            onPressed: (email!.isEmpty || password!.isEmpty)
                                ? null
                                : () {
                                    if (loginformkey.currentState!.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });

                                      setState(() {
                                        isLoading = true;
                                      });
                                      userService
                                          .login('$email', '$password')
                                          .then((value) {
                                        setState(() {
                                          isLoading = false;
                                        });

                                        Navigator.of(context)
                                            .pushNamed(Leave_Screen.routename);
                                      }).catchError((error) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Map msg = jsonDecode(error.message);
                                        SnackBarService.displaySnackBar(msg['message']).show(context);
                                      });
                                    }
                                  },
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
                    onTap: () {
                      Navigator.of(context).pushNamed(ForgotPassword.routename);
                    },
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
    );
  }

  Future uploadImageToFirebase() async {
    print(_file);
    final fileName = basename(_file!.path);
    // final destination = 'files/$fileName';
    // final uploadTask = UploadFileService.uploadFile(destination, _file!);

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    // Reference ref = firebaseStorage.ref().child("nx-images-${DateTime.now()}");
    // UploadTask uploadTask = ref.putFile(_file!);
    // uploadTask?.then((res) {
    //   res.ref.getDownloadURL().then((value) => print("Done: $value"));
    // });
    var reference = FirebaseStorage.instance.ref().child("ncuti").child("images").child("${DateTime.now()}");
    final TaskSnapshot snapshot = await reference.putFile(_file!);
    final downloadUrl = await snapshot.ref.getDownloadURL();
    print("Done: $downloadUrl");
  }
}
