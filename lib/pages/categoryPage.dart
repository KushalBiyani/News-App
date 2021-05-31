import 'package:flutter/material.dart';
import 'package:my_news_app/blocs/newsBloc.dart';
import 'package:my_news_app/theme/theme.dart';
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
          bloc.setCagegory = type;
          widget.controller.animateToPage(0,
              duration: Duration(milliseconds: 300), curve: Curves.linear);
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                    // height:50,
                    color: Colors.red,
                    child: customImage(imgPath, fit: BoxFit.cover))),
            Text(text,
                style: AppTheme.h2Style
                    .copyWith(color: Theme.of(context).backgroundColor))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(
            'Category',
            style: AppTheme.h2Style,
          ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () {})
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: GridView.count(
            childAspectRatio: .8,
            mainAxisSpacing: 20,
            crossAxisSpacing: 0,
            crossAxisCount: 3,
            children: <Widget>[
              _categoryCard('Tech', 'technology',
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSs77jFDj9CMVP5ixm7ryIB2WPbUkGRAHBclciGzQYhxq_Dz-IU'),
              //  _categoryCard('Fashion','https://thumbs.dreamstime.com/b/abstract-woman-portrait-fashion-background-hand-painted-art-illustration-56110086.jpg'),
              _categoryCard('Economy', 'business',
                  'https://st.depositphotos.com/1776223/2024/i/950/depositphotos_20243063-stock-photo-a-hand-holding-a-fan.jpg'),
              _categoryCard('Sport', 'sports',
                  'https://i.pinimg.com/736x/47/2c/af/472caf46a80db324dd52b00812459a65.jpg'),
              _categoryCard('Health', 'health',
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTaCep4PcqSpssotFl08L8j9TNlE0WrYZdP_Ej6BjW-RXArQoFO'),
              _categoryCard('Entertainment', 'entertainment',
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTj8smVeHddjHD8AlOmvVx7CEX8t_nS81iW-UamtjKkG-q5BMi8'),
              _categoryCard('Science', 'science',
                  'https://c.wallhere.com/photos/34/7f/nature_photography_portrait_display-36961.jpg!d'),
              _categoryCard('General', 'general',
                  'https://66.media.tumblr.com/3e368d4f495ab3e07b0c7114955b48dc/tumblr_mz8od094wc1rtp2uuo1_500.jpg'),
            ],
          ),
        ));
  }
}
