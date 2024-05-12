import 'package:flutter/material.dart';
import 'package:tpm_tugas_4/model/clubs.dart';
import 'package:tpm_tugas_4/model/favorites.dart';
import 'package:tpm_tugas_4/utils/favorite.dart';
import 'package:tpm_tugas_4/view/components/heading.dart';
import 'package:url_launcher/url_launcher.dart';

class ClubListPage extends StatefulWidget {
  final String id;
  const ClubListPage({super.key, required this.id});

  @override
  State<ClubListPage> createState() => _ClubListPageState();
}

class _ClubListPageState extends State<ClubListPage> {
  String msg = "";
  Future? _future;
  List<int> favClubsId = [];

  Future<void> _favHandler(BuildContext context, bool isFav, String id) async {
    try {
      final response = await (isFav
          ? Favorite.deleteFav(widget.id, id)
          : Favorite.addFav(widget.id, id));
      msg = response["message"];
    } catch (e) {
      msg = "Can't connect to server.";
    } finally {
      if (context.mounted) {
        SnackBar snackBar = SnackBar(
          content: Text(msg),
          duration: Durations.long2,
        );
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _future = Favorite.getFavByUserId(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Premier League Clubs")),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: const Color.fromARGB(255, 249, 249, 249),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Heading(
                text: "Premier League Clubs",
                subtext:
                    "List of all clubs participating in the Premier League 2023/2024.",
              ),
              const SizedBox(height: 12),
              _buildClubs(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClubs() {
    return Expanded(
      child: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            Favorites favClubModel = Favorites.fromJson(snapshot.data);
            final bool isError = favClubModel.status == "Error";
            if (isError) return _buildError(favClubModel.message!);

            // Filter club
            favClubsId = [...?favClubModel.data];
            return _clubListContainer(context);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _clubListContainer(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int count = (width > 1280)
        ? 4
        : (width > 840)
            ? 3
            : 2;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: count,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: width > 840 ? 1 : 0.8),
      itemBuilder: (context, index) => _clubItem(context, clubList[index]),
      itemCount: clubList.length,
    );
  }

  Widget _clubItem(BuildContext context, Clubs club) {
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
              club.logo,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                club.name,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                club.code,
                style: const TextStyle(
                    fontSize: 14, color: Color.fromARGB(128, 0, 0, 0)),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        _launchURL(club.url);
                      },
                      child: const Text('Visit Website'),
                    ),
                  ),
                  const SizedBox(width: 6),
                  IconButton(
                    style: IconButton.styleFrom(
                      foregroundColor: favClubsId.contains(club.id)
                          ? Colors.red
                          : Colors.black26,
                      backgroundColor: favClubsId.contains(club.id)
                          ? Colors.red.shade50
                          : Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: const BorderSide(
                          color: Color.fromARGB(26, 0, 0, 0),
                          width: 1.5,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      await _favHandler(
                        context,
                        favClubsId.contains(club.id),
                        (club.id).toString(),
                      );
                      setState(() {});
                      _future = Favorite.getFavByUserId(widget.id);
                    },
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

  Widget _buildError(String msg) {
    return Container(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        msg,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
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
