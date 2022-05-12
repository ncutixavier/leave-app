import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: const BoxDecoration(
          color: Color(0xFFAD0B63),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(35.0),
            bottomRight: Radius.circular(35.0),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: Image.asset("images/logo.png"),
            height: height * 0.12,
          ),
          SizedBox(
            height: height * 0.05,
          ),
          const Text(
            "This is Leave Management System",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
