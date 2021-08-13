import 'package:flutter/material.dart';
import 'package:news/screens/news_screen.dart';
import 'package:news/viewmodels/news_article_list_view_model.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News',
        theme: ThemeData(
      primarySwatch: Colors.red,
      visualDensity: VisualDensity.adaptivePlatformDensity,

        ),
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => NewsArticleListViewModel(),
            )
          ],
          child: NewsScreen(),
        ));
  }
}
