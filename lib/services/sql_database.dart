import 'dart:async';
import 'dart:io' as io;
import 'package:news/models/news_article.dart';
import 'package:news/viewmodels/news_article_view_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "news.db");
    var theDb = await openDatabase(path, version: 8, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Article(id INTEGER PRIMARY KEY, title TEXT, description TEXT, publishedAt TEXT,urlToImage TEXT )");
    print("Created tables");
  }

  void saveArticle(NewsArticleViewModel article) async {
    var dbClient = await db;

    // String title = article.title.replaceAll(new RegExp(r'[^\w\s]+'),'');
    // String t = title.replaceAll(new RegExp(' '),'');
    // String desc = article.description.replaceAll(new RegExp(r'[^\w\s]+'),'');
    // String d = desc.replaceAll(new RegExp(' '),'');

    await dbClient.transaction((txn) async {
      return await txn.rawInsert('INSERT INTO Article(title, description, publishedAt, urlToImage) VALUES( ?  , ? , ? , ? )',[ article.title , article.description , article.publishedAt, article.imageUrl ]);
    });
  }

  Future<List<NewsArticle>> getArticles() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Article');
    List<NewsArticle> articles = new List();
    for (int i = 0; i < list.length; i++) {
      articles.add(
          new NewsArticle(
              title : list[i]["title"],
              description : list[i]["description"],
              urlToImage : list[i]["urlToImage"],
              publishedAt : list[i]["publishedAt"]
          )
      );
    }
    print(articles.length);
    return articles;
  }
}