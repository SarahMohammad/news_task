import 'package:cached_network_image/cached_network_image.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:news/models/news_article.dart';
import 'package:news/viewmodels/favorite_view_model.dart';
import 'package:news/viewmodels/news_article_view_model.dart';
import 'package:news/widgets/circle_image.dart';
import 'package:provider/provider.dart';

class NewsArticleDetailScreen extends StatelessWidget {
  final NewsArticleViewModel article;

  NewsArticleDetailScreen({@required this.article});

  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<FavoriteViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Details')
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                Text(
                  this.article.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    wordSpacing: 3,
                  ),
                ),
                // Favourite Button
                FavoriteButton(
                  isFavorite: false,
                  valueChanged: (_isFavorite) {
                    print('Is Favorite : $_isFavorite');
                    provider.saveArticleToDatabase(this.article);
                    //call method from view model to
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  this.article.publishedAt,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(this.article.imageUrl),
              fit: BoxFit.cover)
        ),


                  // CircleImage(
                  //   imageUrl: this.article.imageUrl,
                  // ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  this.article.description ?? "No Contents",
                  style: TextStyle(
                    fontSize: 16,
                    wordSpacing: 3,
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
