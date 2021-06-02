import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_news_app/resources/repository.dart';
import 'newsEvent.dart';
import 'newsState.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final Repository repository;

  NewsBloc({this.repository})
      : assert(repository != null),
        super(Loading());

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is Fetch) {
      try {
        yield Loading();
        final items = await repository.fetchAllNews(
            category: event.type, search: event.search);
        yield Loaded(items: items, type: event.type);
      } catch (_) {
        yield Failure();
      }
    }
  }
}
