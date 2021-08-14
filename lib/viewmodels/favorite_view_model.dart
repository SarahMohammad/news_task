import 'package:flutter/material.dart';
import 'package:news/models/news_article.dart';
import 'package:news/services/db_helper.dart';



class FavoriteViewModel with ChangeNotifier {
  List<NewsArticle> articles = [];

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
              ),).toList();
    notifyListeners();
  }

  void saveArticleToDatabase(NewsArticle article) async {
    var dbHelper = DBHelper();
    dbHelper.saveArticle(article);
  }

  doesRowExist(String title) async {
    var dbHelper = DBHelper();
    bool boolean = await dbHelper.doesArticleExist(title)  ;
    return boolean;
  }

  deleteRecord(String title) async {
    var dbHelper = DBHelper();
    dbHelper.deleteRecord(title)  ;
  }
}

