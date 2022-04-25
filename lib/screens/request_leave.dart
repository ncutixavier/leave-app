import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';

class RequestLeave extends StatefulWidget {
  const RequestLeave({Key? key}) : super(key: key);

  @override
  State<RequestLeave> createState() => _RequestLeaveState();
}

class _RequestLeaveState extends State<RequestLeave> {
  var numberOfDays;
  DateTime? startDate;
  DateTime? returnDate;
  var type;
  var reason;
  final List<String> leaveType = [
    "Sick Leave",
    "Vacancies leave",
    "Maternity leave"
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: Color(0xff757575),
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              )),
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    height: 70.0,
                    child: Text(
                      "Request a leave",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 20, fontFamily: "Inter-Bold"),
                    ),
                  ),
                  SizedBox(
                    height: 80.0,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: 'Enter number of days ',
                        border: OutlineInputBorder(),
                        labelText: 'Number of days',
                      ),
                      onChanged: (value) {
                        setState(() {
                          numberOfDays = value;
                        });
                      },
                      validator: (value) {
                        // Check if this field is empty
                        if (value == null || value.isEmpty) {
                          return 'Number of days is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 80.0,
                    child: DateTimeFormField(
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black45),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.event_note),
                        labelText: 'Start date',
                      ),
                      mode: DateTimeFieldPickerMode.date,
                      autovalidateMode: AutovalidateMode.always,
                      validator: (DateTime? e) {
                        return (e?.day ?? 0) == 1
                            ? 'Start date is required'
                            : null;
                      },
                      onDateSelected: (DateTime value) {
                        var dat = value.add(Duration(days: 6));
                        print('Date:: $dat');
                        setState(() {
                          startDate = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height:
                    (startDate == null || numberOfDays == null) ? 0.0 : 45.0,
                    child: (startDate == null || numberOfDays == null)
                        ? Text("")
                        : Text(
                      "Return date: ${DateFormat('yyyy-MM-dd').format(startDate!.add(Duration(days: int.parse(numberOfDays))))}",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  SizedBox(
                    height: 80.0,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                          isDense: true,
                          border: const OutlineInputBorder(),
                          labelText: "Type of leave"),
                      items: leaveType.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'type is required';
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          type = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 110.0,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: 'Reason/Comment',
                        border: OutlineInputBorder(),
                        labelText: 'Reason/Comment',
                      ),
                      maxLines: 3,
                      onChanged: (value) {
                        setState(() {
                          reason = value;
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
                      onPressed: () {},
                      child: const Text(
                        'Send a request',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
