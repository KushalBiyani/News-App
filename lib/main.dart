import 'package:flutter/material.dart';
import 'package:my_news_app/pages/homepage/homePage.dart';
import 'package:my_news_app/theme/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      home: MyHomePage(),
    );
  }
}
