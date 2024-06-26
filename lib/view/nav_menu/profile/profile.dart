import 'package:flutter/material.dart';
import 'package:tpm_tugas_4/model/auth.dart';
import 'package:tpm_tugas_4/utils/session.dart';
import 'package:tpm_tugas_4/view/auth/login.dart';
import 'package:tpm_tugas_4/view/nav_menu/profile/help/help.dart';

class ProfilePage extends StatelessWidget {
  final SessionCredential data;
  const ProfilePage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 12),
        const SizedBox(height: 128, child: Icon(Icons.person, size: 128)),
        const SizedBox(height: 12),
        Text(
          data.name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text("@${data.username}", style: const TextStyle(fontSize: 16)),
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

  void logoutHandler(BuildContext context) async {
    await SessionManager.logout();
    if (!context.mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return const LoginPage();
      }),
    );
  }
}
