class NewsArticle {
   String title;
   String author;
   String description;
   String urlToImage;
   String url;
   String publishedAt;
   String content;

  NewsArticle(
      {this.title,
      this.author,
      this.description,
      this.urlToImage,
      this.url,
      this.publishedAt,
      this.content});

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'],
      author: json['author'],
      description: json['description'],
      urlToImage: json['urlToImage'],
      url: json['url'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }

}
