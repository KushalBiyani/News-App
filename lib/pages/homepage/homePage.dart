import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_news_app/model/newsResponseModel.dart';
import 'package:my_news_app/pages/homepage/bloc/bloc.dart';
import 'package:my_news_app/pages/newsDetail/bloc/bloc.dart';
import 'package:my_news_app/theme/theme.dart';
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
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Hero(
            tag: 'headerImage',
            child: customImage(article.urlToImage),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 10, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  article.title,
                  style: kh1Style,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
    BuildContext context,
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
                      type: type.toUpperCase(),
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
            return Center(child: Text('Something went wrong'));
          }
          if (state is Loaded) {
            if (state.items == null || state.items.isEmpty) {
              return Text('No content avilable');
            } else {
              return _body(context, state.items, type: state.type);
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}
