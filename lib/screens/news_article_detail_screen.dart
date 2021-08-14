import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:news/models/news_article.dart';
import 'package:news/viewmodels/favorite_view_model.dart';
import 'package:provider/provider.dart';

class NewsArticleDetailScreen extends StatelessWidget {
  final NewsArticle article;

  NewsArticleDetailScreen({@required this.article});

  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<FavoriteViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Details'),
        backgroundColor: Colors.red[900],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 20),
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: provider.doesRowExist(article.title), // async work
              builder: (BuildContext context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting: return Text('Loading....');
                  default:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          //urlToImage
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(image:
                                this.article.urlToImage !=null ? NetworkImage( this.article.urlToImage)
                                    : Image.asset('assets/images/errorimg.jpeg',width: MediaQuery.of(context).size.width,height: 200,),
                                    fit: BoxFit.cover)
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //title
                          Text(
                            this.article.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              wordSpacing: 3,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                this.article.publishedAt,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              FavoriteButton(
                                isFavorite: snapshot.data ? true : false ,
                                valueChanged: (_isFavorite) {
                                  print('Is Favorite : $_isFavorite');
                                  _isFavorite? provider.saveArticleToDatabase(this.article):
                                  provider.deleteRecord(this.article.title);
                                  //call method from view model to
                                },
                              ),
                            ],
                          ),
                          // Favourite Button
                          SizedBox(
                            height: 20,
                          ),


                          //description
                          Text(
                            this.article.description ?? "No Contents",
                            style: TextStyle(
                              fontSize: 16,
                              wordSpacing: 3,
                            ),
                          ),
                        ],
                      );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
