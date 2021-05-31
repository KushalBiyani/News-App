import 'package:flutter/material.dart';
import 'package:my_news_app/pages/categoryPage.dart';
import 'package:my_news_app/pages/profilePage.dart';
import 'package:my_news_app/pages/videoNewsPage.dart';
import 'package:my_news_app/widgets/bottomNavigationBar.dart';
import 'homePage/homePage.dart';

class NewsApp extends StatefulWidget {
  NewsApp({Key key}) : super(key: key);

  @override
  _NewsAppState createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(controller: _controller),
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          VideoNewsPage(),
          CategoryPage(
            controller: _controller,
          ),
          ProfilePage(),
        ],
      ),
    );
  }
}
