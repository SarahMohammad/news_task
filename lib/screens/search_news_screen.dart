import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:news/models/news_article.dart';
import 'package:news/viewmodels/favorite_view_model.dart';
import 'package:news/viewmodels/search_news_view_model.dart';
import 'package:news/widgets/news_list.dart';
import 'package:provider/provider.dart';

import 'news_article_detail_screen.dart';

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
      appBar: AppBar(
          title:Text("Search News")
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
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
                },
              ),
            ),
            Expanded(
                child: ListView.builder(
                  itemCount: provider.articles.length,
                  itemBuilder: (BuildContext _, int index) {
                    final article = provider.articles[index];

                    return GestureDetector(
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (_) {
                          //   return  MultiProvider(
                          //     providers: [
                          //       ChangeNotifierProvider(
                          //         create: (_) => FavoriteViewModel(),
                          //       )
                          //     ],
                          //     child: NewsArticleDetailScreen(
                          //       article: article,
                          //     ),
                          //   );
                          // }));
                        },
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(image: NetworkImage(article.urlToImage),
                                            fit: BoxFit.cover)
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      alignment: Alignment.center,
                                      child: Text(
                                        article.title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,

                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8,),

                            ]
                        )



                    );
                  },
                ))
          ],
        ),
      )

      // SafeArea(
      //   child: Padding(
      //     padding: const EdgeInsets.only(left: 30, right: 20),
      //     child: SingleChildScrollView(
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.stretch,
      //         children: <Widget>[
      //           TextField(
      //             controller: vs.searchTextController,
      //             decoration: InputDecoration(
      //               prefixIcon: Icon(Icons.search),
      //             ),
      //           ),
      //           // Expanded(
      //           //   child: Text("pp"),
      //           // )
      //
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
