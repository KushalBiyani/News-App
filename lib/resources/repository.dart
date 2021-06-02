// @dart=2.9
import 'package:my_news_app/model/newsResponseModel.dart';

import 'newsApiProvider.dart';

class Repository {
  final NewsApiProvider newsApiProvider = NewsApiProvider();

  Future<List<Article>> fetchAllNews({String category = 'General'}) =>
      newsApiProvider.fetchNewsList(category: category);
}
