import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_news_app/model/newsResponseModel.dart';
import 'package:my_news_app/pages/homepage/bloc/bloc.dart';
import 'package:my_news_app/pages/newsDetail/bloc/bloc.dart';
import 'package:my_news_app/helper/constants.dart';
import 'package:my_news_app/widgets/customWidget.dart';

class VideoNewsPage extends StatelessWidget {
  Widget _headerNews(BuildContext context, Article article) {
    return InkWell(
      onTap: () {
        BlocProvider.of<DetailBloc>(context)
            .add(SelectNewsForDetail(article: article));
        Navigator.pushNamed(context, '/detail');
      },
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Hero(
                tag: 'headerImage',
                child: article.urlToImage == null || article.urlToImage.isEmpty
                    ? customImage('images/noImage.jpg',
                        fit: BoxFit.cover, asset: true)
                    : customImage(article.urlToImage, fit: BoxFit.cover),
              ),
              article.urlToImage != null
                  ? Align(
                      child: Padding(
                      padding: EdgeInsets.all(10),
                      child: _playWidget(context),
                    ))
                  : Container()
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 15, right: 5, bottom: 8, top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  article.title,
                  style: kh4Style.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(article.getTime(), style: kh6Style),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _playWidget(BuildContext context) {
    return SizedBox(
      height: 40,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Container(
            height: 40,
            alignment: Alignment.center,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.teal),
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 40,
            )),
      ),
    );
  }

  Widget _body(
    List<Article> list, {
    String type,
  }) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => _headerNews(context, list[index]),
                childCount: list.length)),
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
