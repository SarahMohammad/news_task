import 'package:flutter/material.dart';
import 'package:news/models/news_article.dart';
import 'package:news/services/sql_database.dart';
import 'package:news/viewmodels/news_article_view_model.dart';

enum LoadingStatus {
  completed,
  searching,
  empty,
}

class FavoriteViewModel with ChangeNotifier {
  // LoadingStatus loadingStatus = LoadingStatus.searching;
  List<NewsArticle> articles = List<NewsArticle>();


  List _items = [];
  List get items {
    return _items;
  }

   fetchArticlesFromDatabase() async {
    var dbHelper = DBHelper();
    articles = await dbHelper.getArticles()  ;

    _items = articles
        .map(
          (item) =>
              NewsArticle(

                  title : item.title,
                  description : item.description,
                  urlToImage : item.urlToImage,
                  publishedAt : item.publishedAt
              ),
    )
        .toList();


    notifyListeners();
  }

  void saveArticleToDatabase(NewsArticleViewModel article) async {
    var dbHelper = DBHelper();
    dbHelper.saveArticle(article);
  }
}

