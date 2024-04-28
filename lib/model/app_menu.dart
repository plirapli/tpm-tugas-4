import 'package:flutter/material.dart';
import 'package:tpm_tugas_4/view/main_menu/about_me.dart';
import 'package:tpm_tugas_4/view/main_menu/clubs.dart';
import 'package:tpm_tugas_4/view/main_menu/prime.dart';

class AppMenu {
  String? title;
  IconData? icon;
  Widget? page;

  AppMenu({this.title, this.icon, this.page});
}

List<AppMenu> menuItems = [
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
    page: const ClubListPage(),
  ),
  AppMenu(
    title: "Favorite",
    icon: Icons.star,
    page: null,
  ),
  AppMenu(
    title: "About Me",
    icon: Icons.info_outline,
    page: const AboutMePage(),
  ),
];
