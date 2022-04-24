import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leaveapp/screens/login.dart';
import 'package:leaveapp/widgets/leave_card.dart';
import 'package:leaveapp/screens/request_leave.dart';

class Leave_Screen extends StatefulWidget {
  const Leave_Screen({Key? key}) : super(key: key);
  static const routename = "leaves";
  @override
  State<Leave_Screen> createState() => _Leave_ScreenState();
}

class _Leave_ScreenState extends State<Leave_Screen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff638FFF),
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(isScrollControlled: true, context: context, builder: (context)=>RequestLeave());
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Leaves",
                    style: TextStyle(fontSize: 20, fontFamily: "Inter-Bold"),
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                          const BorderSide(color: Color(0xff638FFF))),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(Login_Screen.routename);
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: ListView(
                      children: List.generate(30, (index) => LeaveCard()),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
