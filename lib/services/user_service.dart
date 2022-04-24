import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:leaveapp/models/user_login.dart';

class UserService {
  final String api = "http://localhost:3000/api/v1";

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
    print(response.body);

    if (response.statusCode == 200) {
      return UserLogin.fromJson(jsonDecode(response.body));
    } else {
      dynamic err = jsonEncode(response.body);
      var message = err["message"];
      print(message);
      throw Exception('$message');
    }
  }
}
