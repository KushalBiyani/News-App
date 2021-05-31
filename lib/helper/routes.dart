import 'package:flutter/material.dart';
import 'package:my_news_app/pages/categoryPage.dart';
import 'package:my_news_app/pages/homepage/homePage.dart';
import 'package:my_news_app/pages/newsApp.dart';
import 'package:my_news_app/pages/newsDetailPage.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => NewsApp(),
      '/home': (_) => HomePage(),
      '/detail': (_) => NewsDetailPage(),
      '/category': (_) => CategoryPage(),
    };
  }
}
