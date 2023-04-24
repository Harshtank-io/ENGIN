import 'package:engin/model/game_Model.dart';
import 'package:engin/service/gameService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class categoryGameListPage extends StatefulWidget {
  final String category;

  const categoryGameListPage({Key? key, required this.category, required List<Game> games}) : super(key: key);

  @override
  _categoryGameListPageState createState() => _categoryGameListPageState();
}

class _categoryGameListPageState extends State<categoryGameListPage> {
  late Future<List<Game>> _games;

  @override
  void initState() {
    super.initState();
    _loadGames();
  }

  void _loadGames() {
    _games = GameService.searchGames(widget.category.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: Center(
        child: FutureBuilder<List<Game>>(
          future: _games,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Game> games = snapshot.data!;
              return ListView.builder(
                itemCount: games.length,
                itemBuilder: (context, index) {
                  Game game = games[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Card(
                      child: ListTile(
                        leading: Image.network(game.backgroundImageUrl!),
                        title: Text(
                          game.name,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(game.released!),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.pushNamed(context, '/game_details', arguments: game);
                        },
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
