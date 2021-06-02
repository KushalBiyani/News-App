import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_news_app/model/newsResponseModel.dart';
import 'package:my_news_app/pages/homepage/bloc/bloc.dart';
import 'package:my_news_app/pages/homepage/newsCard.dart';
import 'package:my_news_app/pages/newsDetail/bloc/bloc.dart';
import 'package:my_news_app/theme/theme.dart';
import 'package:my_news_app/widgets/customWidget.dart';

class VideoNewsPage extends StatelessWidget {
  Widget _headerNews(BuildContext context, Article article) {
    return InkWell(
        onTap: () {
          BlocProvider.of<DetailBloc>(context)
              .add(SelectNewsForDetail(article: article));
          Navigator.pushNamed(context, '/detail');
        },
        child: Container(
            width: MediaQuery.of(context).size.width * 6,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    customImage(article.urlToImage, fit: BoxFit.fitWidth),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 10, bottom: 20),
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
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
                          )
                        ],
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: _playWidget(context),
                        ))
                  ],
                ))));
  }

  Widget _playWidget(BuildContext context) {
    return SizedBox(
      height: 35,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Container(
            height: 35,
            alignment: Alignment.center,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.teal),
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 35,
            )),
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
            child: AspectRatio(
                aspectRatio: 16 / 9,
                child: PageView.builder(
                  itemBuilder: (context, index) {
                    return _headerNews(context, list[index]);
                  },
                  itemCount: 5,
                ))),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => NewsCard(
                      artical: list[index + 1],
                      isVideoNews: true,
                      type: type.toUpperCase(),
                    ),
                childCount: list.length - 1)),
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
