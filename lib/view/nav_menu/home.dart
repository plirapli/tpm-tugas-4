import 'package:flutter/material.dart';
import 'package:tpm_tugas_4/model/app_menu.dart';
import 'package:tpm_tugas_4/model/auth.dart';
import 'package:tpm_tugas_4/view/main_menu/about_me.dart';
import 'package:tpm_tugas_4/view/main_menu/clubs.dart';
import 'package:tpm_tugas_4/view/main_menu/favorite.dart';
import 'package:tpm_tugas_4/view/main_menu/prime.dart';
import 'package:tpm_tugas_4/view/main_menu/triangle/main.dart';

class HomePage extends StatefulWidget {
  final SessionCredential data;
  const HomePage({super.key, required this.data});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String keyword = "";

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 20),
        _heading(),
        _mainmenu(context),
        const SizedBox(height: 20)
      ],
    );
  }

  Widget _heading() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hello, ${widget.data.name}  👋🏻",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Text(
            "Welcome to Sugab app.",
          ),
        ],
      ),
    );
  }

  Widget _mainmenu(BuildContext context) {
    List<AppMenu> menuItems = [
      AppMenu(
        title: "Prime Numbers",
        icon: Icons.pin_outlined,
        page: const PrimePage(),
      ),
      AppMenu(
        title: "Triangle",
        icon: Icons.change_history,
        page: const TrianglePage(),
      ),
      AppMenu(
        title: "Premier League Clubs",
        icon: Icons.sports_soccer,
        page: ClubListPage(id: widget.data.id),
      ),
      AppMenu(
        title: "Favorite",
        icon: Icons.star_outline,
        page: FavoritePage(id: widget.data.id),
      ),
      AppMenu(
        title: "About Me",
        icon: Icons.info_outline,
        page: const AboutMePage(),
      ),
    ];

    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 4),
      child: Column(
        children: [
          for (final item in menuItems)
            _mainmenuitem(context, item.title, item.icon, item.page)
        ],
      ),
    );
  }

  Widget _mainmenuitem(
    BuildContext context,
    String? title,
    IconData? icon,
    Widget? page,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: TextButton(
        style: TextButton.styleFrom(padding: const EdgeInsets.all(16)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page!),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title!, style: const TextStyle(fontSize: 18)),
            Icon(icon!, color: Colors.white)
          ],
        ),
      ),
    );
  }
}
