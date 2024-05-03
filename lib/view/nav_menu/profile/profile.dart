import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tpm_tugas_4/view/auth/login.dart';
import 'package:tpm_tugas_4/view/nav_menu/profile/help/help.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final authStorage = GetStorage('auth');

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 12),
        const SizedBox(height: 128, child: Icon(Icons.person, size: 128)),
        const SizedBox(height: 12),
        const Text(
          "Muhammad Rafli",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        biodata("123210078", Icons.numbers),
        biodata("IF-H", Icons.class_),
        biodata("Bermain Gim & Mendengarkan Musik", Icons.smart_toy),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HelpPage()),
            )
          },
          child: const Text("Help"),
        ),
        const SizedBox(height: 4),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.black12,
            foregroundColor: Colors.black,
          ),
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
