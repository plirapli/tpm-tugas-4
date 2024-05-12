import 'package:flutter/material.dart';
import 'package:tpm_tugas_4/model/clubs.dart';
import 'package:tpm_tugas_4/model/favorites.dart';
import 'package:tpm_tugas_4/utils/favorite.dart';
import 'package:tpm_tugas_4/view/components/heading.dart';
import 'package:url_launcher/url_launcher.dart';

class FavoritePage extends StatefulWidget {
  final String id;
  const FavoritePage({super.key, required this.id});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  String msg = "";
  Future? _future;
  List<int> favClubId = [];
  List<Clubs> favClubs = clubList;

  Future<void> _removeFavorite(BuildContext context, String id) async {
    try {
      final response = await Favorite.deleteFav(widget.id, id);
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
        appBar: AppBar(title: const Text("Favorite Clubs")),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: const Color.fromARGB(255, 249, 249, 249),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Heading(
                text: "Favorite Clubs",
                subtext: "My favorite clubs.",
              ),
              const SizedBox(height: 4),
              _buildFavoriteClubs(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteClubs() {
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
            favClubId = [...?favClubModel.data];
            print(favClubId);
            favClubs = clubList
                .where((club) => favClubId.any((id) => club.id == id))
                .toList();
            return ListView.builder(
              itemBuilder: (context, index) => _clubListItem(context, index),
              itemCount: favClubs.length,
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _clubListItem(BuildContext context, int index) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.fromLTRB(18, 20, 16, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        border: Border.all(color: const Color.fromARGB(32, 0, 0, 0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            favClubs[index].logo,
            fit: BoxFit.fitHeight,
            height: 84,
            width: 84,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  favClubs[index].name,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  favClubs[index].code,
                  style: const TextStyle(
                      fontSize: 14, color: Color.fromARGB(128, 0, 0, 0)),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          _launchURL(favClubs[index].url);
                        },
                        child: const Text('Visit Website'),
                      ),
                    ),
                    const SizedBox(width: 6),
                    IconButton(
                      style: IconButton.styleFrom(
                        foregroundColor: Colors.red,
                        backgroundColor: Colors.red.shade50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: const BorderSide(
                            color: Color.fromARGB(26, 0, 0, 0),
                            width: 1.5,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        await _removeFavorite(
                          context,
                          (favClubs[index].id).toString(),
                        );
                        _future = Favorite.getFavByUserId(widget.id);
                        setState(() {});
                      },
                      icon: const Icon(Icons.favorite),
                    ),
                  ],
                )
              ],
            ),
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
