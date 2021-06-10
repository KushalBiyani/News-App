import 'dart:io';

import 'package:http/http.dart';
import 'package:my_news_app/model/newsResponseModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

void shareNews(Article article) async {
  if (Platform.isAndroid && article.urlToImage != null) {
    var response = await get(Uri.parse(article.urlToImage));

    final documentDirectory = (await getExternalStorageDirectory()).path;
    File imgFile = new File('$documentDirectory/newsApp.png');

    imgFile.writeAsBytesSync(response.bodyBytes);
    Share.shareFiles(['$documentDirectory/newsApp.png'],
        text: article.title + '\n' + article.url);
  }
}
