import 'package:firebase_core/firebase_core.dart';
// Import the generated file
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:leaveapp/screens/splash.dart';
import 'package:leaveapp/screens/login.dart';
import 'package:leaveapp/screens/leave.dart';
import 'package:leaveapp/screens/register.dart';
import 'package:leaveapp/screens/post.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash(),
      routes: {
        'splash': (context) => Splash(),
        'login': (context) => Login_Screen(),
        'register': (context) => Register_Screen(),
        'leaves': (context) => Leave_Screen(),
        'post': (context) => PostsPage()
      },
    );
  }
}
