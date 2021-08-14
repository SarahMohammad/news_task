import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:hidden_drawer_menu/model/item_hidden_menu.dart';
import 'package:hidden_drawer_menu/model/screen_hidden_drawer.dart';
import 'package:news/screens/favorites_screen.dart';
import 'package:news/screens/news_screen.dart';
import 'package:news/screens/search_news_screen.dart';
import 'package:news/viewmodels/favorite_view_model.dart';
import 'package:news/viewmodels/news_article_list_view_model.dart';
import 'package:news/viewmodels/search_news_view_model.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ScreenHiddenDrawer> items = [];

  @override
  void initState() {
    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Top headlines",
          baseStyle: TextStyle( color: Colors.white.withOpacity(0.8), fontSize: 28.0 ),
          colorLineSelected: Colors.red[900], selectedStyle: null,
        ),
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => NewsArticleListViewModel(),
            )
          ],
          child: NewsScreen(),
        ),
    ),
    );

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Search news",
          baseStyle: TextStyle( color: Colors.white.withOpacity(0.8), fontSize: 28.0 ),
          colorLineSelected: Colors.red[900],  selectedStyle: null,
        ),
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => SearchNewsViewModel(),
            )
          ],
          child: SearchNewsScreen(),
        ),
    ),
    );


    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Favorite news",
          baseStyle: TextStyle( color: Colors.white.withOpacity(0.8), fontSize: 28.0 ),
          colorLineSelected: Colors.red[900],  selectedStyle: null,
        ),
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => FavoriteViewModel(),
          )
        ],
        child: FavoriteScreen(),
      ),
    ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return HiddenDrawerMenu(
      backgroundColorMenu: Colors.black87,
      backgroundColorAppBar: Colors.red[900],
      screens: items,
    );

  }
}
