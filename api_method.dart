import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiMethod {
//API to authenticate user login
  static Future<dynamic> login(String username, String password) async {
    var url = Uri.parse(' http://localhost:9001/user/login');
    var response = await http.post(url, body: {
      'username': username,
      'password': password,
    });
    return jsonDecode(response.body);
  }
}