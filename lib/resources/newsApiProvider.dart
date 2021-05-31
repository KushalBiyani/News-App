import 'package:http/http.dart';
import 'package:my_news_app/helper/constants.dart';
import 'package:my_news_app/model/newsResponseModel.dart';

class NewsApiProvider {
  Client client = Client();
  final _apiKey = Constant.newsApiKey;
  Future<List<Article>> fetchNewsList() async {
    print("entered");
    final response = await client.get(Uri.parse(
        "${Constant.baseUrl}${Constant.topHeadLine}?country=in&apiKey=$_apiKey"));
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return NewsApiResonse.fromRawJson(response.body).articles;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
