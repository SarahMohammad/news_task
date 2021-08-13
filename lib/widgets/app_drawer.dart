import 'package:flutter/material.dart';
import 'package:news/screens/favorites_screen.dart';
import 'package:news/screens/news_article_detail_screen.dart';
import 'package:news/screens/news_screen.dart';
import 'package:news/screens/search_news_screen.dart';
import 'package:news/viewmodels/favorite_view_model.dart';
import 'package:news/viewmodels/search_news_view_model.dart';
import 'package:provider/provider.dart';


getAppDrawer(context){
  return Drawer(
    child: ListView(
      children: [
        ListTile(
          title: Text("News Headline"),
          onTap: (){
            // Get.toNamed("/news_headline");
            selectedItem(context , 0);
          },
          leading: Icon(Icons.contact_page_outlined),
        ),
        ListTile(
          title: Text("Search News"),
          onTap: (){
            // Get.toNamed("/search_news");
            selectedItem(context , 1);
          },
          leading: Icon(Icons.search),
        ),
        ListTile(
          title: Text("Favorites news"),
          onTap: (){
            // Get.toNamed("/search_news");
            selectedItem(context , 2);
          },
          leading: Icon(Icons.favorite),
        ),
      ],
    ),
  );
}

void selectedItem(BuildContext context, int index) {
  Navigator.of(context).pop();

  switch (index) {
    case 0:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => NewsScreen(),
      ));
      break;
    case 1:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => SearchNewsViewModel(),
            )
          ],
          child: SearchNewsScreen(),
        )
      ));
      break;
    case 2:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>  MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => FavoriteViewModel(),
            )
          ],
          child: FavoriteScreen(),
        ),
      ));
      break;
  }
}