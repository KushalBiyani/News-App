import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_news_app/pages/categoryPage.dart';
import 'package:my_news_app/pages/countrySelectPage.dart';
import 'package:my_news_app/pages/profilePage.dart';
import 'package:my_news_app/widgets/bottomNavigationBar.dart';
import 'homePage/homePage.dart';

class NewsApp extends StatefulWidget {
  NewsApp({Key key}) : super(key: key);

  @override
  _NewsAppState createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  User currentUser = FirebaseAuth.instance.currentUser;

  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      Navigator.popAndPushNamed(context, '/login');
    }
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(controller: _controller),
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          CountrySelectPage(controller: _controller),
          CategoryPage(controller: _controller),
          ProfilePage(),
        ],
      ),
    );
  }
}
