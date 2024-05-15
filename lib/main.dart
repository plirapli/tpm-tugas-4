import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:tpm_tugas_4/model/auth.dart';
import 'package:tpm_tugas_4/theme.dart';
import 'package:tpm_tugas_4/utils/session.dart';
import 'package:tpm_tugas_4/view/app.dart';
import 'package:tpm_tugas_4/view/auth/login.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobile 4th Assignment',
      theme: themeData(),
      home: FutureBuilder<SessionCredential?>(
        future: SessionManager.getCredential(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            FlutterNativeSplash.remove();
            SessionCredential? data = snapshot.data;
            if (data != null) {
              return AppPage(data: data);
            } else {
              return const LoginPage();
            }
          }
        },
      ),
    );
  }
}
