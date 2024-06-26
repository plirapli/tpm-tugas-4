import 'package:flutter/material.dart';
import 'package:tpm_tugas_4/model/members.dart';
import 'package:tpm_tugas_4/view/components/heading.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMePage extends StatelessWidget {
  const AboutMePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("About Me")),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: const Color.fromARGB(255, 249, 249, 249),
          child: ListView(scrollDirection: Axis.vertical, children: [
            const SizedBox(height: 20),
            const Heading(text: "About Me", subtext: "Get to know me."),
            _groupMenuItem(context, me),
            const SizedBox(height: 20)
          ]),
        ),
      ),
    );
  }

  Widget _groupMenuItem(BuildContext context, Members member) {
    return Container(
      margin: const EdgeInsets.only(top: 14),
      child: Column(children: [
        Container(
            height: 320,
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                    color: const Color.fromARGB(24, 23, 47, 39), width: 2),
                color: Colors.black12,
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
                    fontSize: 16,
                    color: Color.fromARGB(150, 0, 0, 0),
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () => _launchURL(member.url),
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
