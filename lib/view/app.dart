import 'package:flutter/material.dart';
import 'package:tpm_tugas_4/model/app_menu.dart';
import 'package:tpm_tugas_4/model/auth.dart';
import 'package:tpm_tugas_4/view/nav_menu/home.dart';
import 'package:tpm_tugas_4/view/nav_menu/profile/profile.dart';
import 'package:tpm_tugas_4/view/nav_menu/stopwatch.dart';

class AppPage extends StatefulWidget {
  final SessionCredential data;
  const AppPage({super.key, required this.data});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions(SessionCredential credential) {
    return [
      HomePage(data: credential),
      const StopwatchPage(),
      ProfilePage(data: credential),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(navItem[_selectedIndex].label!)),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: const Color.fromARGB(255, 246, 246, 246),
          child: _widgetOptions(widget.data).elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: navItem,
          currentIndex: _selectedIndex,
          unselectedItemColor: const Color.fromARGB(255, 169, 169, 169),
          selectedFontSize: 12.0,
          selectedItemColor: Colors.black,
          onTap: (index) => setState(() => _selectedIndex = index),
        ),
      ),
    );
  }
}
