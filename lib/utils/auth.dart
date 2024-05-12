import 'dart:convert';
import 'package:http/http.dart' as http;

class Auth {
  static const url = "http://localhost:3002/v1";

  static Future<Map<String, dynamic>> login(
      String username, String password) async {
    const endpoint = "/users/login";
    final http.Response response = await http.post(
      Uri.parse(url + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{'username': username, 'password': password},
      ),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> register(
    String name,
    String username,
    String password,
  ) async {
    const endpoint = "/users/register";
    final http.Response response = await http.post(
      Uri.parse(url + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'name': name,
          'username': username,
          'password': password
        },
      ),
    );
    return jsonDecode(response.body);
  }
}
