import 'dart:async';
import 'dart:convert';

import 'package:engin/model/game_Model.dart';
import 'package:http/http.dart' as http;

class GameService {
  static const String key = '6e69a5907aa8465d9cbe345804c47af1';
  static const String baseUrl = 'http://api.rawg.io/api';


  // For fectching the games
  static Future<List<Game>> getGameList() async {
    final response = await http.get(Uri.parse('$baseUrl/games?&key=$key&page_size=100'));
    if(response.statusCode == 200) {
      final data = jsonDecode(response.body);
        final List<dynamic> gameData = data['results'];
        final List<Game> games = gameData.map((game) => Game.fromJson(game)).toList();
        return games;
    }
    throw Exception('Failed to load games');
  }

  // For Seraching the games
  static Future<List<Game>> searchGames(String query) async{
    final response = await http.get(Uri.parse('$baseUrl/games?key=$key&genres=$query&page_size=100'));
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      final List<dynamic> gameData = data['results'];
      final List<Game> games = gameData.map((game) => Game.fromJson(game)).toList();
      return games;
    }
    throw Exception('Failed to Search Game');
  }

}