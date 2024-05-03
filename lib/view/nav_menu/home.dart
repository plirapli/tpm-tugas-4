import 'package:flutter/material.dart';
import 'package:tpm_tugas_4/model/app_menu.dart';
import 'package:tpm_tugas_4/model/auth.dart';
// import 'package:tpm_tugas_4/view/oddeven.dart';
// import 'package:tpm_tugas_4/view/sumsub.dart';
// import 'package:si_bagus/model/mainmenuitem.dart';

class HomePage extends StatefulWidget {
  final SessionCredential data;
  const HomePage({super.key, required this.data});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<AppMenu> filteredItems = [];
  String keyword = "";

  @override
  void initState() {
    super.initState();

    filteredItems = [...menuItems];
  }

  void _search(String val) {
    setState(() {
      keyword = val;
      filteredItems = menuItems
          .where(
              (item) => (item.title!.toLowerCase()).contains(val.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 20),
        _heading(),
        _searchBar(),
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

  Widget _searchBar() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      // padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        enabled: true,
        onChanged: (value) => _search(value),
        decoration: InputDecoration(
          hintText: 'Search your menu',
          prefixIcon: const Icon(Icons.search, color: Colors.black87),
          filled: true,
          fillColor: const Color.fromARGB(0, 0, 0, 0),
          contentPadding: const EdgeInsets.all(12),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.75,
              color: Color.fromARGB(80, 0, 0, 0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              width: 1.75,
              color: Color.fromARGB(80, 0, 0, 0),
            ),
          ),
        ),
      ),
    );
  }

  Widget _mainmenu(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 4),
      child: Column(
        children: filteredItems.isEmpty
            ? [
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(fontSize: 16),
                      children: [
                        const TextSpan(text: "Can't find "),
                        TextSpan(
                          text: keyword,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: " on menu."),
                      ],
                    ),
                  ),
                )
              ]
            : [
                for (final item in filteredItems)
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
