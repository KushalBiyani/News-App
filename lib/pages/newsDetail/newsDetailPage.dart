import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:my_news_app/model/newsResponseModel.dart';
import 'package:my_news_app/pages/homepage/bloc/bloc.dart';
import 'package:my_news_app/pages/newsDetail/bloc/bloc.dart';
import 'package:my_news_app/helper/constants.dart';
import 'package:my_news_app/widgets/customWidget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class NewsDetailPage extends StatelessWidget {
  Widget _headerNews(BuildContext context, Article article) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Hero(
          tag: 'headerImage',
          child: article.urlToImage == null || article.urlToImage.isEmpty
              ? Container()
              : customImage(article.urlToImage),
        ),
        Container(
          padding: EdgeInsets.only(left: 0, right: 10, bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.keyboard_backspace,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              Expanded(child: SizedBox()),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              IconButton(
                onPressed: () async {
                  final RenderBox box = context.findRenderObject();
                  if (Platform.isAndroid && article.urlToImage != null) {
                    var response = await get(Uri.parse(article.urlToImage));
                    final documentDirectory =
                        (await getExternalStorageDirectory()).path;
                    File imgFile = new File('$documentDirectory/newsApp.png');
                    imgFile.writeAsBytesSync(response.bodyBytes);
                    Share.shareFiles(['$documentDirectory/newsApp.png'],
                        text: article.title + '\n' + article.url);
                  }
                },
                icon: Icon(
                  Icons.share,
                  color: Colors.white,
                  size: 32,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _body(BuildContext context, Article article) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: _headerNews(context, article),
        ),
        SliverToBoxAdapter(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text(article.title, style: kh1Style),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Text(article.author ?? '', style: kh6Style),
                  SizedBox(
                    width: 10,
                  ),
                  Text(article.getTime(), style: kh5Style),
                ],
              ),
              Divider(
                height: 20,
                thickness: 2,
              ),
              Text(
                article.content != null
                    ? article.content.substring(0, 200)
                    : '',
                style: kh5Style,
                overflow: TextOverflow.visible,
              ),
              SizedBox(
                height: 20,
              ),
              article.url != null
                  ? InkWell(
                      child: Text(
                        'Full Article at >>',
                        style: kh4Style.copyWith(
                            color: Colors.teal,
                            decoration: TextDecoration.underline),
                      ),
                      onTap: () => launch(article.url))
                  : Container()
            ],
          ),
        ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(child: BlocBuilder<DetailBloc, DetailState>(
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
                return _body(
                  context,
                  state.selectedArticle,
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        )));
  }
}
