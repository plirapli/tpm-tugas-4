import 'package:flutter/material.dart';
import 'package:tpm_tugas_4/model/app_menu.dart';
import 'package:tpm_tugas_4/view/nav_menu/home.dart';
import 'package:tpm_tugas_4/view/nav_menu/profile/profile.dart';
import 'package:tpm_tugas_4/view/nav_menu/stopwatch.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(username: "Rafli"),
    const StopwatchPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(navItem[_selectedIndex].label!)),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: const Color.fromARGB(255, 246, 246, 246),
          child: _widgetOptions.elementAt(_selectedIndex),
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
