import 'package:flutter/material.dart';
import 'package:my_news_app/pages/categoryPage.dart';
import 'package:my_news_app/pages/homepage/homePage.dart';
import 'package:my_news_app/pages/loginScreen.dart';
import 'package:my_news_app/pages/newsApp.dart';
import 'package:my_news_app/pages/newsDetail/newsDetailPage.dart';
import 'package:my_news_app/pages/profilePage.dart';
import 'package:my_news_app/pages/searchNewsPage.dart';
import 'package:my_news_app/pages/splash_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/splashScreen': (_) => Splash(),
      '/': (_) => NewsApp(),
      '/login': (_) => LoginScreen(),
      '/home': (_) => HomePage(),
      '/detail': (_) => NewsDetailPage(),
      '/category': (_) => CategoryPage(),
      '/profile': (_) => ProfilePage(),
      '/searchNews': (_) => SearchNewsPage()
    };
  }
}
