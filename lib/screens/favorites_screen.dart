import 'package:flutter/material.dart';
import 'package:news/viewmodels/favorite_view_model.dart';
import 'package:news/viewmodels/news_article_view_model.dart';
import 'package:news/widgets/circle_image.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<FavoriteViewModel>(context, listen: false)
        .fetchArticlesFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    var vs = Provider.of<FavoriteViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('dd'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 20),
          child: ListView.builder(
            itemCount: vs.items.length,
            itemBuilder: (BuildContext _, int index) {
              final article = vs.items[index];

              return GestureDetector(
                  onTap: () {
                    // _showNewsArticleDetails(context, article);
                  },
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(article.urlToImage),
                        // Container(
                        //     margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        //     child: article.imageUrl != null ?
                        //     Image.network(article.imageUrl,width: MediaQuery.of(context).size.width, height: 200, ) :
                        //     Container(child: SizedBox(width: 200, height: 200,) , color: Colors.amber,)
                        //
                        //   // CircleImage(
                        //   //   imageUrl: article.imageUrl,
                        //   // ),
                        // ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          alignment: Alignment.center,
                          child: Text(
                            article.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            // maxLines: 1,
                            // overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 8,),

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
