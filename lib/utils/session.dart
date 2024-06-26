import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tpm_tugas_4/model/auth.dart';

class SessionManager {
  static const String _credential = 'credential';

  static Future<void> setCredential(String data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_credential, data);
  }

  static Future<SessionCredential?> getCredential() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final credential = prefs.getString(_credential);

    if (credential != null) {
      final result = jsonDecode(credential);
      SessionCredential data = SessionCredential(
        id: result["id"],
        name: result["name"],
        username: result["username"],
      );
      return data;
    }
    return null;
  }

  static Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
