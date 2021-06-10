import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_news_app/pages/homepage/bloc/bloc.dart';
import 'package:my_news_app/pages/newsDetail/bloc/bloc.dart';
import 'package:my_news_app/helper/constants.dart';
import 'package:my_news_app/pages/newsDetail/newsDetailsWidget.dart';

class NewsDetailPage extends StatefulWidget {
  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: BlocBuilder<DetailBloc, DetailState>(
          builder: (context, state) {
            if (state == null) {
              return Center(child: Text('Null bloc'));
            }
            if (state is Failure) {
              return Center(child: Text('Something went wrong'));
            }
            if (state is LoadedArticle) {
              if (state.selectedArticle == null) {
                return Text('No content avilable');
              } else {
                return NewsDetailWidget(article: state.selectedArticle);
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
