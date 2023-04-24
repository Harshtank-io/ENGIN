import 'package:flutter/material.dart';
import 'package:engin/model/game_Model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class GameDetailsPage extends StatelessWidget {
  final Game game;

  const GameDetailsPage({required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(game.name),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(game.backgroundImageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              game.name,
              style: GoogleFonts.poppins(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text("Released: ", style: GoogleFonts.poppins(fontSize: 18.0)),
                Text(
                  game.released?.toString() ?? "",
                  style: GoogleFonts.poppins(fontSize: 18.0),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              'Genres: ${game.genres.map((genre) => genre.name).join(", ")}',
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text(
                  "Rating:",
                  style: GoogleFonts.poppins(fontSize: 18.0),
                ),
                SizedBox(width: 8.0),
                Icon(Icons.star, color: Colors.yellow),
                SizedBox(width: 4.0),
                Text(
                  game.rating.toString(),
                  style: GoogleFonts.poppins(fontSize: 18.0),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              game.description ?? " ",
              style: GoogleFonts.poppins(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                IconButton(
                  icon:Icon(Icons.web),
                  //Image.asset("assets/icons/website.png"),
                  onPressed: () => launchURL(game.websiteUrl!),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  icon: Image.asset("assets/icons/youtube.png"),
                  onPressed: () => launchURL(game.youtubeUrl!),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  icon: Image.asset("assets/icons/store.png"),
                  onPressed: () => launchURL(game.storeUrl!),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
