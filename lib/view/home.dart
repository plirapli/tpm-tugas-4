import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tpm_tugas_4/model/app_menu.dart';
import 'package:tpm_tugas_4/view/auth/login.dart';
// import 'package:tpm_tugas_4/view/oddeven.dart';
// import 'package:tpm_tugas_4/view/sumsub.dart';
// import 'package:si_bagus/model/mainmenuitem.dart';

class HomePage extends StatefulWidget {
  final String username;

  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<AppMenu> filteredItems = [];
  String keyword = "";
  final authStorage = GetStorage('auth');

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
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView(scrollDirection: Axis.vertical, children: [
            const SizedBox(height: 20),
            _heading(context),
            _searchBar(context),
            _mainmenu(context),
            const SizedBox(height: 20)
          ]),
        ),
      ),
    );
  }

  Widget _heading(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello, ${widget.username}  👋🏻",
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Welcome to Sūgaku app.",
                ),
              ],
            ),
            IconButton.filled(
              style: IconButton.styleFrom(
                  minimumSize: const Size(48, 48),
                  foregroundColor: Colors.black,
                  backgroundColor: const Color.fromARGB(66, 124, 124, 124),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6))),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) {
                    authStorage.remove('username');
                    authStorage.remove('isLogged');
                    return const LoginPage();
                  }),
                );
              },
              icon: const Icon(Icons.logout),
            )
          ],
        ));
  }

  Widget _searchBar(BuildContext context) {
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
                        width: 1.75, color: Color.fromARGB(80, 0, 0, 0))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                        width: 1.75, color: Color.fromARGB(80, 0, 0, 0))))));
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
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              const TextSpan(text: " on menu."),
                            ],
                          ),
                        ))
                  ]
                : [
                    for (final item in filteredItems)
                      _mainmenuitem(
                          context, item.title, item.icon, item.page, item.color)
                  ]));
  }

  Widget _mainmenuitem(BuildContext context, String? title, IconData? icon,
      Widget? page, Color? color) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page!),
          );
        },
        style: TextButton.styleFrom(
            padding: const EdgeInsets.all(18),
            backgroundColor: color!,
            foregroundColor: const Color.fromARGB(174, 0, 0, 0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            title!,
            style: const TextStyle(fontSize: 18),
          ),
          Icon(icon!)
        ]),
      ),
    );
  }
}
