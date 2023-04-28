import 'dart:convert';

import 'package:engin/model/newsArticle.dart';
import 'package:http/http.dart' as http;

class GameNewsService {
  static const String apiKey = '492ed7bae6104e8a90729f4e21d09604';
  static const String baseUrl = 'https://newsapi.org/v2';

  static Future<List<Article>> getLatestGameNews() async {
    final response = await http.get(Uri.parse('$baseUrl/everything?q=games&pageSize=100&apiKey=$apiKey'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> articleData = data['articles'];
      final List<Article> articles = articleData.map((article) => Article.fromJson(article)).toList();
      return articles;
    }
    throw Exception('Failed to load game news');
  }

  static Future<List<Article>> searchGameNews(String query) async {
    final url = Uri.parse('$baseUrl/everything?q=$query&sortBy=popularity&apiKey=$apiKey');
    final response = await http.get(url);
    final parsed = json.decode(response.body);

    if (parsed['status'] == 'ok') {
      return (parsed['articles'] as List)
          .map((article) => Article.fromJson(article))
          .toList();
    } else {
      throw Exception(parsed['message']);
    }
  }

}

