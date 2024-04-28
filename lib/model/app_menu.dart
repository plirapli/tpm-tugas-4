import 'package:flutter/material.dart';

class AppMenu {
  String? title;
  IconData? icon;
  Widget? page;
  Color? color;

  AppMenu({this.title, this.icon, this.page, this.color});
}

List<AppMenu> menuItems = [
  AppMenu(
      title: "Group Members",
      icon: Icons.group,
      page: null,
      color: const Color.fromARGB(255, 128, 255, 210)),
  AppMenu(
      title: "Odd or Even",
      icon: Icons.pin,
      page: null,
      color: const Color.fromARGB(255, 151, 238, 255)),
  AppMenu(
      title: "Sum & Sub",
      icon: Icons.calculate,
      page: null,
      color: const Color.fromARGB(255, 255, 247, 140))
];
