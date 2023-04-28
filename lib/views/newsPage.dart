// import 'package:engin/model/newsArticle.dart';
// import 'package:engin/service/gameNewsService.dart';
// import 'package:engin/views/detailNews.dart';
// import 'package:flutter/material.dart';
//
// class NewsPage extends StatefulWidget {
//   const NewsPage({Key? key}) : super(key: key);
//
//   @override
//   _NewsPageState createState() => _NewsPageState();
// }
//
// class _NewsPageState extends State<NewsPage> {
//   late Future<List<Article>> _futureArticles;
//
//   @override
//   void initState() {
//     super.initState();
//     _futureArticles = GameNewsService.getLatestGameNews();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Video Game News'),
//       ),
//       body: FutureBuilder<List<Article>>(
//         future: _futureArticles,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final articles = snapshot.data!;
//             return GestureDetector(
//               onTap: () {
//                 Navigator.push(context,MaterialPageRoute(builder: (context) => DetailNewsPage(articles : articles)));
//               },
//               child: ListView.builder(
//                 itemCount: articles.length,
//                 itemBuilder: (context, index) {
//                   final article = articles[index];
//                   return ListTile(
//                     leading: article.urlToImage.isNotEmpty
//                         ? Image.network(
//                       article.urlToImage,
//                       height: 60,
//                       width: 60,
//                       fit: BoxFit.cover,
//                     )
//                         : const Icon(Icons.image),
//                     title: Text(article.title),
//                     subtitle: Text(article.author),
//                   );
//                 },
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('${snapshot.error}'),
//             );
//           }
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:engin/model/newsArticle.dart';
import 'package:engin/service/gameNewsService.dart';
import 'package:engin/views/detailNews.dart';
import 'package:engin/views/searchNews.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late Future<List<Article>> _futureArticles;
  List<Article> articles = [];
  final TextEditingController searchController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _futureArticles = GameNewsService.getLatestGameNews();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
      ),
      child: FutureBuilder<List<Article>>(
        future: _futureArticles,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final articles = snapshot.data!;
            return Column(
              children: [
                top(context),
                // SizedBox(height: 30),
                // SearchNewsPage(),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      final article = articles[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailNewsPage(articles: article),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: article.urlToImage.isNotEmpty
                              ? Image.network(
                            article.urlToImage,
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          )
                              : const Icon(Icons.image),
                          title: Text(article.title),
                          subtitle: Text(article.author),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
  Widget top(BuildContext context){
    return SafeArea(
      child: ListTile(
        title: Align(
          alignment: Alignment.topLeft,
          child: Text(
            "NEWS",
            style: GoogleFonts.roboto(
                fontSize: 60,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }

}
