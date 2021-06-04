import 'package:flutter/material.dart';
import 'package:my_news_app/privateKey.dart';

class Constant {
  static const String newsApiKey = api_key;
  static const String baseUrl = 'https://newsapi.org/v2/';
  static const String topHeadLine = '/top-headlines';
}

Color kBackgroundColor = Color(0x70000000);
TextStyle kh1Style = TextStyle(
  letterSpacing: 1.5,
  color: Colors.white,
  fontSize: 24,
  fontWeight: FontWeight.bold,
);
TextStyle kh2Style = TextStyle(color: Colors.white, fontSize: 22);
TextStyle kh3Style = TextStyle(color: Colors.white, fontSize: 20);
TextStyle kh4Style = TextStyle(color: Colors.white, fontSize: 18);
TextStyle kh5Style = TextStyle(color: Colors.white, fontSize: 16);
TextStyle kh6Style = TextStyle(color: Colors.white, fontSize: 15);
TextStyle kAppbarText =
    TextStyle(fontWeight: FontWeight.w600, fontSize: 28, letterSpacing: 1);
List<Map<String, String>> listOfCountry = [
  {
    "name": "America",
    "code": "us",
  },
  {
    "name": "Brazil",
    "code": "br",
  },
  {
    "name": "China",
    "code": "cn",
  },
  {
    "name": "England",
    "code": "gb",
  },
  {
    "name": "France",
    "code": "fr",
  },
  {
    "name": "Hong Kong",
    "code": "hk",
  },
  {
    "name": "India",
    "code": "in",
  },
  {
    "name": "Indonesia",
    "code": "id",
  },
  {
    "name": "Israel",
    "code": "il",
  },
  {
    "name": "Italy",
    "code": "it",
  },
  {
    "name": "Japan",
    "code": "jp",
  },
  {
    "name": "Mexico",
    "code": "mx",
  },
  {
    "name": "New Zealand",
    "code": "nz",
  },
  {
    "name": "Russia",
    "code": "ru",
  },
  {
    "name": "Saudi Arabia",
    "code": "sa",
  },
  {
    "name": "Singapore",
    "code": "sg",
  },
  {
    "name": "South Africa",
    "code": "za",
  },
  {
    "name": "Switzerland",
    "code": "ch",
  },
  {
    "name": "Turkey",
    "code": "tr",
  },
  {
    "name": "Thailand",
    "code": "th",
  },
  {
    "name": "UAE",
    "code": "ae",
  },
];
