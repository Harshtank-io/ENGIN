import 'package:engin/service/gameService.dart';
import 'package:engin/views/GameDetailsPage.dart';
import 'package:engin/views/categoryPage.dart';
import 'package:flutter/material.dart';
import 'package:engin/model/game_Model.dart';


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Game> _searchResults = [];
  bool _isLoading = false;

  Future<void> _searchGames(String query) async {
    setState(() {
      _isLoading = true;

    });
    try {
      final results = await GameService.searchGames(query);
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      print('Error searching games: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30,),
          Container(
            width: 350,
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: TextField(
                controller: _searchController,
                decoration:  InputDecoration(
                  hintText: 'Search games...',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                ),
                onSubmitted: (query) {
                  _searchGames(query);
                },
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _searchResults.isEmpty
                ? Center(
                child: CategoryPage(),
            )
                : Container(
              height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                  final game = _searchResults[index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GameDetailsPage(game : game)));
                    },
                    child: ListTile(
                      title: Text(game.name),
                      subtitle: Text(game.released.toString()),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(game.backgroundImageUrl ?? ""),
                      ),
                    ),
                  );
              },
            ),
                ),
          ),
        ],
      ),
    );
  }
}
