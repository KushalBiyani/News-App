import 'package:my_news_app/model/newsResponseModel.dart';
import 'package:my_news_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class NewsBloc {
  final _repository = Repository();
  final _newsListFetcher = PublishSubject<List<Article>>();
  var _selectedrticle = Article();

  Stream<List<Article>> get allNews => _newsListFetcher.stream;
  Article get selectedNews => _selectedrticle;

  fetchAllNews() async {
    List<Article> itemModel = await _repository.fetchAllNews();
    _newsListFetcher.sink.add(itemModel);
  }

  set setNews(Article article) {
    _selectedrticle = article;
  }

  dispose() {
    _newsListFetcher.close();
  }
}

final bloc = NewsBloc();