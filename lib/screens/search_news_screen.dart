import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:news/models/news_article.dart';
import 'package:news/screens/news_article_detail_screen.dart';
import 'package:news/viewmodels/favorite_view_model.dart';
import 'package:news/viewmodels/search_news_view_model.dart';
import 'package:provider/provider.dart';

class SearchNewsScreen extends StatefulWidget {
  @override
  State<SearchNewsScreen> createState() => _SearchNewsScreenState();
}

class _SearchNewsScreenState extends State<SearchNewsScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<SearchNewsViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SearchNewsViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: TypeAheadField<NewsArticle>(
            hideSuggestionsOnKeyboardHide: false,
            textFieldConfiguration: TextFieldConfiguration(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                hintText: 'Search News',
              ),
            ),
            suggestionsCallback: provider.searchNewsHeadline,
            itemBuilder: (context, NewsArticle suggestion) {
              final article = suggestion;
              return ListTile(
                leading: Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(article.urlToImage),
                          fit: BoxFit.cover),
                  ),
                ),
                title: Text(article.title),
              );
            },
            noItemsFoundBuilder: (context) => Container(
              height: 100,
              child: Center(
                child: Text(
                  'No News Found.',
                ),
              ),
            ),
            onSuggestionSelected: (NewsArticle suggestion) {
              final article = suggestion;
              print(article.title);

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
            },
          ),
        ),
      )
    );
  }
}
