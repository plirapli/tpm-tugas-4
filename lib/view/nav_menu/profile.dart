import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tpm_tugas_4/view/auth/login.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final authStorage = GetStorage('auth');

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        const SizedBox(height: 20),
        Container(
          height: 200,
          decoration: const BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.all(Radius.circular(14)),
            image: DecorationImage(
              image: AssetImage("assets/rapli.png"),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Muhammad Rafli",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        biodata("123210078", Icons.numbers),
        biodata("IF-H", Icons.class_),
        biodata("Bermain Gim & Mendengarkan Musik", Icons.smart_toy),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () => logoutHandler(context),
          child: const Text("Logout"),
        ),
        const SizedBox(height: 20)
      ],
    );
  }

  Widget biodata(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(top: 2),
      child: Row(
        children: [Icon(icon, size: 16), const SizedBox(width: 4), Text(title)],
      ),
    );
  }

  void logoutHandler(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        authStorage.remove('username');
        authStorage.remove('isLogged');
        return const LoginPage();
      }),
    );
  }
}
