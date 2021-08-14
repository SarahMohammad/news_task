import 'package:flutter/material.dart';
import 'package:news/models/news_article.dart';
import 'package:news/screens/news_article_detail_screen.dart';
import 'package:news/viewmodels/favorite_view_model.dart';
import 'package:provider/provider.dart';

class NewsList extends StatelessWidget {
  final List<NewsArticle> articles;

  NewsList({this.articles});

  void _showNewsArticleDetails(BuildContext context, NewsArticle article) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return  MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => FavoriteViewModel(),
          )
        ],
        child: NewsArticleDetailScreen(
          article: article,
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
                    child: article.urlToImage != null ?
                    Image.network(article.urlToImage,width: MediaQuery.of(context).size.width, height: 200, ) :
                     Image.asset('assets/images/errorimg.jpeg',width: MediaQuery.of(context).size.width,height: 200,),

        ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.center,
                  child: Text(
                    article.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                ),
                SizedBox(height: 20,),

              ]
          )

        );
      },
    );
  }
}
