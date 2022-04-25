import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:leaveapp/models/department.dart';

class DepartmentService {
  final String api = "http://nx-leave-app.herokuapp.com/api/v1";

  Future<List<Department>> getDepartments() async {
    Response res = await get(Uri.parse(api + '/departments'));
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      List<dynamic> body = data['departments'];

      List<Department> departments = body
          .map(
            (dynamic item) => Department.fromJson(item),
          )
          .toList();
      return departments;
    } else {
      throw "Unable to retrieve departments.";
    }
  }
}
