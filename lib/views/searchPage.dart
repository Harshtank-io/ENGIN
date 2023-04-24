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
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search games...',
            border: InputBorder.none,
          ),
          onSubmitted: (query) {
            _searchGames(query);
          },
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _searchResults.isEmpty
          ? Center(
          child: CategoryPage(),)
          : ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final game = _searchResults[index];
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => GameDetailsPage(game : game)));
            },
            child: ListTile(
              title: Text(game.name),
              subtitle: Text(game.released?.toString() ?? ""),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(game.backgroundImageUrl as String),
              ),
            ),
          );
        },
      ),
    );
  }
}
