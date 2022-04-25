import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:leaveapp/models/user_login.dart';
import 'package:leaveapp/models/user_register.dart';
import 'api.dart';

class UserService {
  final Api api = new Api();

  Future<UserRegister> register(String email, String password, String name, String department) async {
    Map data = {
      'email': email,
      'password': password,
      'name': name,
      'department_name': department
    };
    var response = await http.post(
        api.register(),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8")
    );

    if (response.statusCode == 201) {
      return UserRegister.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  Future<UserLogin> login(String email, String password) async {
    Map data = {
      'email': email, 'password': password
    };
    var response = await http.post(
      Uri.parse("https://nx-leave-app.herokuapp.com/api/v1/users/login"),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: data,
      encoding: Encoding.getByName("utf-8")
    );

    if (response.statusCode == 200) {
      return UserLogin.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }
}
