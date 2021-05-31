import 'package:my_news_app/model/newsResponseModel.dart';
import 'newsApiProvider.dart';

class Repository {
  final moviesApiProvider = NewsApiProvider();

  Future<List<Article>> fetchAllNews() => moviesApiProvider.fetchNewsList();
}