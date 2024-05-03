import 'dart:convert';
import 'package:http/http.dart' as http;

class Login {
  static Future<List<dynamic>> login(String username, String password) async {
    const url = "http://localhost:3002/v1/users/login";
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'username': username, 'password': password}),
    );
    return [jsonDecode(response.body), response.statusCode];
  }
  // try {
  //   final response = await http.post(
  //     Uri.parse(url),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(
  //         <String, String>{'username': username, 'password': password}),
  //   );
  //   final String body = response.body;
  //   final int statusCode = response.statusCode;
  //   msg = jsonDecode(body)["message"];

  //   if (!mounted) return;
  //   ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text(msg), duration: Durations.long2));

  //   if (statusCode == 200) {
  //     final data = jsonDecode(body)["data"];
  //     await SessionManager.setCredential(jsonEncode(data));
  //     // Navigator.pushReplacement(
  //     //   context,
  //     //   MaterialPageRoute(builder: (context) {
  //     //     return HomePage(username: username);
  //     //   }),
  //     // );
  //   } else {
  //     setState(() => isError = true);
  //   }
  // } catch (e) {
  //   print(e);
  //   // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //   //     content: Text("Can't connect to server."),
  //   //     duration: Durations.long2));
  //   setState(() => isError = true);
  // }
}
