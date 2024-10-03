import 'dart:convert';
import 'package:http/http.dart' as http;

class Favorite {
  static const _url = "http://localhost:3005/v1/favorites/";
  static const _header = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8'
  };

  static Future<Map<String, dynamic>> getFavByUserId(String id) async {
    final http.Response response = await http.get(Uri.parse(_url + id));
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> addFav(
    String userId,
    String clubId,
  ) async {
    final http.Response response = await http.post(
      Uri.parse(_url + userId),
      headers: _header,
      body: jsonEncode(<String, String>{'club_id': clubId}),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> deleteFav(
    String userId,
    String clubId,
  ) async {
    final http.Response response = await http.delete(
      Uri.parse(_url + userId),
      headers: _header,
      body: jsonEncode(<String, String>{'club_id': clubId}),
    );
    return jsonDecode(response.body);
  }
}
