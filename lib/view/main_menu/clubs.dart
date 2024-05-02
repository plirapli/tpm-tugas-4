import 'package:flutter/material.dart';
import 'package:tpm_tugas_4/model/clubs.dart';
import 'package:tpm_tugas_4/view/components/heading.dart';
import 'package:url_launcher/url_launcher.dart';

class ClubListPage extends StatefulWidget {
  const ClubListPage({super.key});

  @override
  State<ClubListPage> createState() => _ClubListPageState();
}

class _ClubListPageState extends State<ClubListPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Group Members")),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: const Color.fromARGB(255, 249, 249, 249),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Heading(
                text: "Premier League Clubs",
                subtext:
                    "List of all clubs participating in the Premier League 2023/2024.",
              ),
              const SizedBox(height: 12),
              _clubListContainer(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _clubListContainer(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    int count = (width > 1280)
        ? 4
        : (width > 840)
            ? 3
            : 2;

    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: width > 840 ? 1 : 0.8),
        itemBuilder: (context, index) => _clubListItem(context, index),
        itemCount: clubList.length,
      ),
    );
  }

  Widget _clubListItem(BuildContext context, int index) {
    return Container(
      // height: 89,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        border: Border.all(color: const Color.fromARGB(32, 0, 0, 0)),
      ),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              clubList[index].logo,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                clubList[index].name,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                clubList[index].code,
                style: const TextStyle(
                    fontSize: 14, color: Color.fromARGB(128, 0, 0, 0)),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                        fixedSize: const Size.fromHeight(38),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        _launchURL(clubList[index].url);
                      },
                      child: const Text('Visit Website'),
                    ),
                  ),
                  const SizedBox(width: 6),
                  IconButton(
                    style: IconButton.styleFrom(
                      foregroundColor: Colors.black26,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: const BorderSide(
                          color: Color.fromARGB(26, 0, 0, 0),
                          width: 1.5,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.favorite),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String strUrl) async {
    Uri url = Uri.parse(strUrl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
