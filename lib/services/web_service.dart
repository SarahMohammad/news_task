import 'package:dio/dio.dart';
import 'package:news/models/news_article.dart';
import 'package:news/utils/constants.dart';

class WebService {
  var dio = new Dio();

  Future<List<NewsArticle>> fetchNewsSearch(String query) async {
    final response = await dio.get(Constants.newsSearch(query));
    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result['articles'];
      // return users.map((json) => User.fromJson(json)).where((user) {
      //   final nameLower = user.name.toLowerCase();
      //   final queryLower = query.toLowerCase();
      //
      //   return nameLower.contains(queryLower);
      // }).toList();
      return list.map((article) => NewsArticle.fromJson(article)).where((article) {
        final nameLower = article.title.toLowerCase();
           final queryLower = query.toLowerCase();
           return nameLower.contains(queryLower);

      }).toList();
    } else {
      throw Exception("Failled to get search news");
    }
  }


  Future<List<NewsArticle>> fetchTopHeadlines() async {
    String url = Constants.TOP_HEADLINES_URL;

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result['articles'];
      return list.map((article) => NewsArticle.fromJson(article)).toList();
    } else {
      throw Exception("Failled to get top news");
    }
  }
}
