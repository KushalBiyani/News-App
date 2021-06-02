import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_news_app/pages/homepage/bloc/bloc.dart';
import 'package:my_news_app/helper/constants.dart';
import 'package:my_news_app/pages/videoNewsPage.dart';
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
          BlocProvider.of<NewsBloc>(context)
              .add(Fetch(type: type, search: null));
          BlocProvider.of<NavigationBloc>(context).add(Navigate(pageIndex: 0));

          widget.controller.animateTo(0,
              duration: Duration(milliseconds: 300), curve: Curves.linear);
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: Theme.of(context).primaryColor,
                    child: customImage(imgPath, fit: BoxFit.cover))),
            Text(text, style: kh2Style)
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          elevation: 5,
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
                })
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
              _categoryCard('Tech', 'technology',
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSs77jFDj9CMVP5ixm7ryIB2WPbUkGRAHBclciGzQYhxq_Dz-IU'),
              _categoryCard('Economy', 'business',
                  'https://st.depositphotos.com/1776223/2024/i/950/depositphotos_20243063-stock-photo-a-hand-holding-a-fan.jpg'),
              _categoryCard('Sport', 'sports',
                  'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?ixlib=rb-1.2.1&w=1000&q=80'),
              _categoryCard('Health', 'health',
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTaCep4PcqSpssotFl08L8j9TNlE0WrYZdP_Ej6BjW-RXArQoFO'),
              _categoryCard('Fun', 'entertainment',
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTj8smVeHddjHD8AlOmvVx7CEX8t_nS81iW-UamtjKkG-q5BMi8'),
              _categoryCard('Science', 'science',
                  'https://c.wallhere.com/photos/34/7f/nature_photography_portrait_display-36961.jpg!d'),
              _categoryCard('General', 'general',
                  'https://66.media.tumblr.com/3e368d4f495ab3e07b0c7114955b48dc/tumblr_mz8od094wc1rtp2uuo1_500.jpg'),
              _categoryCard('Music', '',
                  'https://i.pinimg.com/originals/06/c6/b5/06c6b57d26549b1ebdab20926a9e9e1e.jpg'),
              _categoryCard('Arts', '',
                  'https://vistapointe.net/images/fan-art-wallpaper-2.jpg'),
            ],
          ),
        ));
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
    return VideoNewsPage();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
