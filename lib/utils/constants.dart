class Constants {
  static const String API_KEY = '0c5e8e7f434342a482ea1f077d486534';
  static const String TOP_HEADLINES_URL = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$API_KEY';
  static String newsSearch(String query) {
    return 'https://newsapi.org/v2/everything?q=$query&apiKey=$API_KEY';
  }

}