import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news/models/news_article.dart';
import 'package:news/services/db_helper.dart';
import 'package:news/services/web_service.dart';
import 'fetch_headlines_test.mocks.dart';


class MockDatabase extends Mock implements DBHelper {}
class MockModel extends Mock implements NewsArticle{}

@GenerateMocks([http.Client])
void main() {
  MockDatabase _mockDatabase = MockDatabase();
  MockModel _model = MockModel();
  _model.title = "title";
  group('fetchNews', () {

    test("Mock Database call", () async {
      when(_mockDatabase.getArticles()).thenAnswer(
            (realInvocation) => Future.value(
              <NewsArticle>[_model],
        ),
      );
      await _mockDatabase.getArticles();
      expect(_model.title, "title");
    });


    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();
      when(client
          .get(Uri.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=0c5e8e7f434342a482ea1f077d486534')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect( WebService().fetchTopHeadlines(), throwsException);
    });
  });
}

