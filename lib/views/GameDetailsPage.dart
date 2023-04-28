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
        backgroundColor: Colors.white,
        elevation: 0.1,
        leading:IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
            icon: Icon(Icons.arrow_back_ios,color: Colors.black,))
        ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 370,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(game.backgroundImageUrl!),
                      fit: BoxFit.cover,
                    ),
                    // boxShadow:[
                    //   BoxShadow(
                    //     color: Colors.grey.withOpacity(0.3), //color of shadow
                    //     spreadRadius: 5, //spread radius
                    //     blurRadius: 7, // blur radius
                    //     offset: Offset(0, 2), // changes position of shadow
                    //   ),
                    // ],
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
                  'Genres: ${game.genres?.map((genre) => genre.name).join(", ")}',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Platforms: ${game.platforms?.map((pla) => pla.name).join(", ")}',
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
                Row(
                  children: [
                    IconButton(
                      icon:Icon(Icons.web),
                      //Image.asset("assets/icons/website.png"),
                      onPressed: () => launchURL(game.websiteUrl!),
                    ),
                    SizedBox(width: 8.0),
                    IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: () => launchURL(game.youtubeUrl!),
                    ),
                    SizedBox(width: 8.0),
                    IconButton(
                      icon: Icon(Icons.store,size: 30,),
                      onPressed: () => launchURL(game.storeUrl!),
                    ),
                  ],
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
