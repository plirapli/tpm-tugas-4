import 'package:flutter/material.dart';
import 'package:tpm_tugas_4/view/main_menu/prime.dart';

class AppMenu {
  String? title;
  IconData? icon;
  Widget? page;

  AppMenu({this.title, this.icon, this.page});
}

List<AppMenu> menuItems = [
  AppMenu(
    title: "Group Members",
    icon: Icons.group,
    page: null,
  ),
  AppMenu(
    title: "Prime Numbers",
    icon: Icons.pin_outlined,
    page: const PrimePage(),
  ),
  AppMenu(
    title: "Triangle",
    icon: Icons.change_history,
    page: null,
  ),
  AppMenu(
    title: "Premier League Clubs",
    icon: Icons.sports_soccer,
    page: null,
  ),
  AppMenu(
    title: "Favorite",
    icon: Icons.star,
    page: null,
  ),
];
