import 'package:flutter/cupertino.dart';
import 'package:news/models/news_article.dart';
import 'package:news/services/web_service.dart';

class SearchNewsViewModel with ChangeNotifier {

  Future<List<NewsArticle>>searchNewsHeadline(query) async{
    return await WebService().fetchNewsSearch(query);
  }
}