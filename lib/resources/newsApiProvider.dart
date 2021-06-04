import 'package:http/http.dart' as http;
import 'package:my_news_app/helper/constants.dart';
import 'package:my_news_app/model/newsResponseModel.dart';

class NewsApiProvider {
  final _apiKey = Constant.newsApiKey;
  final http.Client httpClient = http.Client();

  Future<List<Article>> fetchNewsList(
      {String category = "", String search = "", String country = ""}) async {
    Uri url;
    if (country != null) {
      url = Uri.parse(
          "${Constant.baseUrl}${Constant.topHeadLine}?country=$country&apiKey=$_apiKey");
    } else if (search == "" || search == null) {
      url = Uri.parse(
          "${Constant.baseUrl}${Constant.topHeadLine}?country=in&apiKey=$_apiKey&category=$category");
    } else {
      url = Uri.parse(Uri.encodeFull(
          Constant.baseUrl + 'everything?q=' + search + '&apiKey=' + _apiKey));
      print(search);
    }
    final response = await this.httpClient.get(url);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return NewsApiResonse.fromRawJson(response.body).articles;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
