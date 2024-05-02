import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tpm_tugas_4/theme.dart';
import 'package:tpm_tugas_4/view/app.dart';
import 'package:tpm_tugas_4/view/auth/login.dart';
import 'package:tpm_tugas_4/view/main_menu/clubs.dart';
import 'package:tpm_tugas_4/view/nav_menu/home.dart';

void main() async {
  await GetStorage.init('auth');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authStorage = GetStorage('auth');
    bool isLoggedIn = authStorage.read('isLogged') ?? false;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mobile 4th Assignment',
        theme: themeData(),
        // home: isLoggedIn
        //     ? HomePage(username: authStorage.read('username'))
        //     : const LoginPage(),
        home: const AppPage());
  }
}
