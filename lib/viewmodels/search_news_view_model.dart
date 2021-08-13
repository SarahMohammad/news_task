import 'package:flutter/cupertino.dart';
import 'package:news/models/news_article.dart';
import 'package:news/services/web_service.dart';
import 'package:news/viewmodels/news_article_view_model.dart';

class SearchNewsViewModel with ChangeNotifier {

  // final searchTextController = TextEditingController();
  //
  // SearchNewsController(){
  //   searchTextController.addListener(() {
  //     if(searchTextController.text.length%3==0 && searchTextController.text.length!=0){
  //       searchNewsHeadline();
  //     }
  //   });
  // }


  bool isLoading = false;

  List<NewsArticle> articles = List();

  Future<List<NewsArticle>>searchNewsHeadline(query) async{

    // showLoading();

    final result = await WebService().fetchNewsSearch(query);

    // hideLoading();

    if(result!= null){
      articles = result;
      notifyListeners();
      print ("there is a result");
    }else{
      print("No data recieved");
    }
  }

  // showLoading(){
  //   isLoading.toggle();
  // }
  //
  // hideLoading(){
  //   isLoading.toggle();
  // }
}