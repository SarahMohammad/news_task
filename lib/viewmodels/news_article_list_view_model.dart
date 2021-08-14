import 'package:flutter/material.dart';
import 'package:news/models/news_article.dart';
import 'package:news/services/web_service.dart';

enum LoadingStatus {
  completed,
  searching,
  empty,
}

class NewsArticleListViewModel with ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.searching;
  List<NewsArticle> articles = [];

  void searchNews(String query) async {
    this.loadingStatus = LoadingStatus.searching;
    notifyListeners();

    List<NewsArticle> newsArticles =
        await WebService().fetchNewsSearch(query);

    this.articles = newsArticles
        .map((article) => NewsArticle(title :article.title,
        author :article.author,
        description : article.description,
        urlToImage : article.urlToImage,
        url : article.url,
        publishedAt : article.publishedAt,
        content : article.content))
        .toList();

    if (this.articles.isEmpty) {
      this.loadingStatus = LoadingStatus.empty;
    } else {
      this.loadingStatus = LoadingStatus.completed;
    }

    notifyListeners();
  }

  void topHeadlines() async {

    List<NewsArticle> newsArticles = await WebService().fetchTopHeadlines();
    notifyListeners();

    this.articles = newsArticles
        .map((article) => NewsArticle(title :article.title,
        author :article.author,
        description : article.description,
        urlToImage : article.urlToImage,
        url : article.url,
        publishedAt : article.publishedAt,
        content : article.content))
        .toList();

    if (this.articles.isEmpty) {
      this.loadingStatus = LoadingStatus.empty;
    } else {
      this.loadingStatus = LoadingStatus.completed;
    }

    notifyListeners();
  }
}
