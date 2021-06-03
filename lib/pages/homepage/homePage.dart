import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_news_app/model/newsResponseModel.dart';
import 'package:my_news_app/pages/homepage/bloc/bloc.dart';
import 'package:my_news_app/pages/newsDetail/bloc/bloc.dart';
import 'package:my_news_app/helper/constants.dart';
import 'package:my_news_app/widgets/customWidget.dart';

import 'newsCard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _headerNews(Article article) {
    return InkWell(
      onTap: () {
        final detailBloc = BlocProvider.of<DetailBloc>(context);
        detailBloc.add(SelectNewsForDetail(article: article));
        Navigator.pushNamed(context, '/detail');
      },
      child: Column(
        children: <Widget>[
          Hero(
            tag: 'headerImage',
            child: article.urlToImage == null || article.urlToImage.isEmpty
                ? customImage('images/noImage.jpg',
                    fit: BoxFit.cover, asset: true)
                : customImage(article.urlToImage, fit: BoxFit.cover),
          ),
          Container(
            padding: EdgeInsets.only(left: 15, right: 5, bottom: 5, top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  article.title,
                  style: kh3Style.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(article.getTime(), style: kh6Style),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _body(
    List<Article> list, {
    String type,
  }) {
    return CustomScrollView(
      slivers: <Widget>[
        buildAppBar(type),
        SliverToBoxAdapter(
          child: _headerNews(list.first),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => NewsCard(
                      artical: list[index + 1],
                      type: type == null ? "GENERAL" : type.toUpperCase(),
                    ),
                childCount: list.length - 1))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
          if (state == null) {
            return Center(child: Text('Null block'));
          }
          if (state is Failure) {
            return Center(
                child: Text(
              'Something went wrong',
              style: kh2Style,
            ));
          }
          if (state is Loaded) {
            if (state.items == null || state.items.isEmpty) {
              return Center(
                  child: Text(
                'No content avilable',
                style: kh2Style,
              ));
            } else {
              return _body(state.items, type: state.type);
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}
