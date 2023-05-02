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
        physics: BouncingScrollPhysics(),
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
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  game.name,
                  style: GoogleFonts.poppins(fontSize: 26.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Text(
                      "Rating:",
                      style: GoogleFonts.poppins(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Icon(Icons.star, color: Colors.yellow[800]),
                    SizedBox(width: 4.0),
                    Text(
                      game.rating.toString(),
                      style: GoogleFonts.poppins(fontSize: 18.0),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Text("Released: ", style: GoogleFonts.poppins(
                        fontSize:20.0,
                      fontWeight: FontWeight.bold
                    )),
                    Text(
                      game.released?.toString() ?? "",
                      style: GoogleFonts.poppins(fontSize: 18.0),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Text('Genres : ',style: GoogleFonts.poppins(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    ),),
                    Text(
                      '${game.genres?.map((genre) => genre.name).join(", ")}',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Stores:',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: game.stores.map((st) => Chip(label: Text(st.name))).toList() ?? [],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Platforms:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: game.platforms?.map((plt) => Chip(label: Text(plt.name))).toList() ??
                          [],
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tags:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: game.tags?.map((tag) => Chip(label: Text(tag.name))).toList() ??
                          [],
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
  void launchStore(String? storeUrl) async {
    if (storeUrl != null && await canLaunch(storeUrl)) {
      await launch(storeUrl);
    } else {
      throw 'Could not launch store';
    }
  }
  }
