import 'package:flutter/material.dart';

class LeaveCard extends StatelessWidget {
  const LeaveCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Requested on Jan 10",
                  style: TextStyle(color: Color(0xff888888)),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffD8DC03),
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Text(
                    "Pending",
                    style: TextStyle(color: Color(0xffD8DC03)),
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              width: double.infinity,
              child: const Text(
                "From Wed 12 Jan - Fri 14 Jan",
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Text(
                    "Sick Leave",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Color(0xff638FFF)),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  tooltip: 'More',
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
