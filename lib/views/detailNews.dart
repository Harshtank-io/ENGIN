import 'package:flutter/material.dart';
import 'package:engin/model/newsArticle.dart';

class DetailNewsPage extends StatelessWidget {
  final Article articles;

  const DetailNewsPage({Key? key, required this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(articles.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (articles.urlToImage.isNotEmpty)
              Image.network(
                articles.urlToImage,
                height: 200,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 16),
            Text(
              articles.title,
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 8),
            Text(
              articles.author,
              style: Theme.of(context).textTheme.caption,
            ),
            const SizedBox(height: 8),
            Text(articles.description),
            const SizedBox(height: 16),
            Text(
              articles.content,
              //textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
