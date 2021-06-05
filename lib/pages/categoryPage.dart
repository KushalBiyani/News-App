import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_news_app/pages/homepage/bloc/bloc.dart';
import 'package:my_news_app/helper/constants.dart';
import 'package:my_news_app/pages/searchNewsPage.dart';
import 'package:my_news_app/widgets/bloc/bloc.dart';
import 'package:my_news_app/widgets/customWidget.dart';

class CategoryPage extends StatefulWidget {
  final PageController controller;
  CategoryPage({Key key, this.controller}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  Widget _categoryCard(String text, String type, String imgPath) {
    return InkWell(
      onTap: () {
        BlocProvider.of<NewsBloc>(context).add(Fetch(type: type, search: null));
        BlocProvider.of<NavigationBloc>(context).add(Navigate(pageIndex: 0));
        widget.controller.animateTo(0,
            duration: Duration(milliseconds: 300), curve: Curves.linear);
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child:
                        customImage(imgPath, fit: BoxFit.fill, asset: true))),
          ),
          Text(text, style: kh2Style)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 5,
        leading: Container(),
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          'News Category',
          style: kAppbarText,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: Search(),
              );
            },
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: GridView.count(
          padding: EdgeInsets.symmetric(vertical: 20),
          childAspectRatio: .8,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
          children: <Widget>[
            _categoryCard('Tech', 'technology', 'tech.jpg'),
            _categoryCard('Economy', 'business', 'economy.jpg'),
            _categoryCard('Sport', 'sports', 'sports.jpg'),
            _categoryCard('Health', 'health', 'health.jpg'),
            _categoryCard('Fun', 'entertainment', 'fun.jpg'),
            _categoryCard('Science', 'science', 'science.jpg'),
            _categoryCard('General', 'general', 'general.jpg'),
            _categoryCard('Music', '', 'music.jpg'),
            _categoryCard('Arts', '', 'art.jpg'),
          ],
        ),
      ),
    );
  }
}

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    BlocProvider.of<NewsBloc>(context).add(Fetch(search: query));
    return SearchNewsPage();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
