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
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late Future<List<Article>> _futureArticles;
  final List<Article> articles = [];

  @override
  void initState() {
    super.initState();
    _futureArticles = GameNewsService.getLatestGameNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Game News'),
      ),
      body: FutureBuilder<List<Article>>(
        future: _futureArticles,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final articles = snapshot.data!;
            return ListView.builder(
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
}
