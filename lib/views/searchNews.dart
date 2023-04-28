import 'package:engin/model/newsArticle.dart';
import 'package:engin/service/gameNewsService.dart';
import 'package:engin/views/detailNews.dart';
import 'package:engin/views/newsPage.dart';
import 'package:flutter/material.dart';



class SearchNewsPage extends StatefulWidget {
  const SearchNewsPage({super.key});

  @override
  _SearchNewsPageState createState() => _SearchNewsPageState();
}

class _SearchNewsPageState extends State<SearchNewsPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Article> articles = [];
  bool _isLoading = false;

  Future<void> searchNews(String query) async{
    setState(() {
      _isLoading = true;
    });
    try{
      final result = await GameNewsService.searchGameNews(query);
      setState(() {
        articles = result;
        _isLoading = false;
      });
    }catch(e){
      print('Error searching games: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
                  searchNews(query);
                },
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : articles.isEmpty
                ? Center(
              child: NewsPage(),
            )
                : ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailNewsPage(
                          articles: article,
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(article.title),
                    subtitle: Text(article.author),
                    leading: CircleAvatar(
                      backgroundImage:
                      NetworkImage(article.urlToImage),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}
