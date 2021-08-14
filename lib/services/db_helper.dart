import 'dart:async';
import 'dart:io' as io;
import 'package:news/models/news_article.dart';
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
        "CREATE TABLE Article(title Text PRIMARY KEY, title TEXT, description TEXT, publishedAt TEXT,urlToImage TEXT )");
    print("Created tables");
  }


  Future<bool> doesArticleExist(String title) async{
    var dbClient = await db;
    var queryResult = await dbClient.rawQuery('SELECT * FROM Article WHERE title=?' ,[title]);
    return queryResult.isEmpty? false : true ;
  }

  Future deleteRecord(String title) async {
    var dbClient = await db;
    return dbClient.rawDelete('DELETE FROM Article WHERE title = ?', [title]);
  }

  void saveArticle(NewsArticle article) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert('INSERT INTO Article(title, description, publishedAt, urlToImage) VALUES( ?  , ? , ? , ? )',[ article.title , article.description , article.publishedAt, article.urlToImage ]);
    });
  }

  Future<List<NewsArticle>> getArticles() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Article');
    List<NewsArticle> articles = [];
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