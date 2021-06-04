import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends NewsEvent {
  final String type;
  final String search;
  final String country;
  Fetch({this.type, this.search, this.country});
  @override
  List<Object> get props => [type];

  @override
  String toString() => 'Fetch $type news';
}
