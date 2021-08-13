import 'package:flutter/material.dart';
import 'package:news/viewmodels/news_article_list_view_model.dart';
import 'package:news/widgets/app_drawer.dart';
import 'package:news/widgets/news_list.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<NewsArticleListViewModel>(context, listen: false)
        .topHeadlines();
  }

  Widget _buildList(NewsArticleListViewModel vs) {
    switch (vs.loadingStatus) {
      case LoadingStatus.searching:
        return Center(
          child: CircularProgressIndicator(),
        );
      case LoadingStatus.completed:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: NewsList(
            articles: vs.articles,
          ),
        );
      case LoadingStatus.empty:
      default:
        return Center(
          child: Text("No results found"),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    var vs = Provider.of<NewsArticleListViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Top Headlines"),
      ),
      body: SafeArea(
        child: Column(
          children: [
             Expanded(
              child: _buildList(vs),
            ),
          ],
        ),
      ),
      drawer: Drawer(
          child: getAppDrawer(context)
      ),
    );
  }
}
