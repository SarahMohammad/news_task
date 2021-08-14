import 'package:flutter/material.dart';
import 'package:news/viewmodels/favorite_view_model.dart';
import 'package:provider/provider.dart';
import 'news_article_detail_screen.dart';

class FavoriteScreen extends StatefulWidget {

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<FavoriteViewModel>(context, listen: false)
        .fetchArticlesFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    var vs = Provider.of<FavoriteViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 20),
          child: ListView.builder(
            itemCount: vs.items.length,
            itemBuilder: (BuildContext _, int index) {
              final article = vs.items[index];
              return GestureDetector(
                  onTap: () {
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
                    }),
                    );
                  },
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(article.urlToImage!=null ? article.urlToImage :
                        Image.asset('assets/images/errorimg.jpeg',width: MediaQuery.of(context).size.width,height: 200,)
                          , ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          alignment: Alignment.center,
                          child: Text(
                            article.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                      ]
                  )
              );
            },
          ),
        ),
      ),
    );
  }
}
