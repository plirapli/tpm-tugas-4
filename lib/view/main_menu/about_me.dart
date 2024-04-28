import 'package:flutter/material.dart';
import 'package:tpm_tugas_4/model/members.dart';
// import 'package:tpm_tugas_4/model/groupitem.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMePage extends StatefulWidget {
  const AboutMePage({super.key});

  @override
  State<AboutMePage> createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Group Members",
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: const Color.fromARGB(255, 249, 249, 249),
          child: ListView(scrollDirection: Axis.vertical, children: [
            const SizedBox(height: 20),
            _heading(),
            _groupMenuItem(context, me),
            const SizedBox(height: 20)
          ]),
        ),
      ),
    );
  }

  Widget _heading() {
    return Container(
        alignment: Alignment.centerLeft,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "About Me",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 23, 47, 39)),
            ),
            Text(
              "Get to know me.",
              style:
                  TextStyle(fontSize: 16, color: Color.fromARGB(150, 0, 0, 0)),
            ),
          ],
        ));
  }

  // Widget _groupContainer(BuildContext context) {
  //   double parentHeight = MediaQuery.of(context).size.height;

  //   return Expanded(
  //     child: Container(
  //         margin: EdgeInsets.only(top: parentHeight <= 640 ? 6 : 20),
  //         child: ListView(
  //           scrollDirection:
  //               parentHeight <= 640 ? Axis.vertical : Axis.horizontal,
  //           children: [
  //             SizedBox(width: parentHeight <= 640 ? 0 : 24),
  //             _groupMenuItem(context, me),
  //           ],
  //         )),
  //   );
  // }

  Widget _groupMenuItem(BuildContext context, Members member) {
    double parentWidth = MediaQuery.of(context).size.width;
    double parentHeight = MediaQuery.of(context).size.height;

    return Container(
      width: parentWidth * 0.8,
      margin: EdgeInsets.only(top: 14),
      child: Column(children: [
        Container(
            height: 320,
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                    color: const Color.fromARGB(24, 23, 47, 39), width: 2),
                color: const Color.fromARGB(255, 180, 255, 229),
                image: DecorationImage(
                    image: AssetImage(member.img!), fit: BoxFit.fitHeight))),
        // Buat container tulisan bawah gambar
        Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name!,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  member.nim!,
                  style: const TextStyle(
                      fontSize: 16, color: Color.fromARGB(150, 0, 0, 0)),
                ),
              ],
            ),
            TextButton(
              style: TextButton.styleFrom(
                  minimumSize: const Size(46, 46),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  // minimumSize: Size(48, 48),
                  // maximumSize: Size(48, 48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () {
                _launchURL(member.url);
              },
              child: Image.asset('assets/github-mark-white.png', width: 24),
            )
          ],
        )
      ]),
    );
  }

  _launchURL(urlPath) async {
    final Uri url = Uri.parse(urlPath);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
