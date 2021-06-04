import 'package:equatable/equatable.dart';
import 'package:my_news_app/model/newsResponseModel.dart';

abstract class NewsDetailEvent extends Equatable {
  const NewsDetailEvent();

  @override
  List<Object> get props => [];
}

class SelectNewsForDetail extends NewsDetailEvent {
  final Article article;
  const SelectNewsForDetail({this.article});

  @override
  String toString() => 'SelectNewsForDetail Page { Title:: ${article.title} }';
}
