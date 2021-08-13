import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/screens/news_article_detail_screen.dart';
import 'package:news/viewmodels/favorite_view_model.dart';
import 'package:news/viewmodels/news_article_view_model.dart';
import 'package:news/widgets/circle_image.dart';
import 'package:provider/provider.dart';

class NewsList extends StatelessWidget {
  final List<NewsArticleViewModel> articles;

  NewsList({this.articles});

  void _showNewsArticleDetails(BuildContext context, NewsArticleViewModel vm) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return  MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => FavoriteViewModel(),
          )
        ],
        child: NewsArticleDetailScreen(
          article: vm,
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.articles.length,
      itemBuilder: (BuildContext _, int index) {
        final article = this.articles[index];
        return GestureDetector(
          onTap: () {
            _showNewsArticleDetails(context, article);
          },
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: article.imageUrl != null ?
                    Image.network(article.imageUrl,width: MediaQuery.of(context).size.width, height: 200, ) :
                    Container(child: SizedBox(width: 200, height: 200,) , color: Colors.amber,)

                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.center,
                  child: Text(
                    article.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 8,),

              ]
          )

        );
      },
    );
  }
}
