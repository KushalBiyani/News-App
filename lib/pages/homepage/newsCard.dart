import 'package:flutter/material.dart';
import 'package:my_news_app/blocs/newsBloc.dart';
import 'package:my_news_app/theme/theme.dart';
import 'package:my_news_app/widgets/customWidget.dart';
import 'package:my_news_app/model/newsResponseModel.dart';

class NewsCard extends StatelessWidget {
  final Article artical;
  final bool isVideoNews;
  const NewsCard({Key key, this.artical, this.isVideoNews = false})
      : super(key: key);
  Widget _playWidget(BuildContext context) {
    return SizedBox(
        height: 20,
        child: FittedBox(
            fit: BoxFit.contain,
            child: Container(
                height: 10,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).backgroundColor),
                child: Icon(
                  Icons.play_arrow,
                  color: Theme.of(context).disabledColor,
                  size: 3,
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          bloc.setNews = artical;
          Navigator.pushNamed(context, '/detail');
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          margin: EdgeInsets.symmetric(vertical: 10),
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Container(
                              color: Theme.of(context).primaryColor,
                              child: artical.urlToImage == null ||
                                      artical.urlToImage.isEmpty
                                  ? Container()
                                  : customImage(artical.urlToImage,
                                      fit: BoxFit.cover)),
                          isVideoNews ? _playWidget(context) : Container()
                        ],
                      ))),
              SizedBox(width: 10),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(),
                  Container(
                    height: 52,
                    child: Text(
                      artical.title,
                      style: AppTheme.titleStyle,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          bloc.getGategory,
                          style: AppTheme.h6Style.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(artical.getDateOnly(),
                            style: AppTheme.subTitleStyle),
                      ),
                    ],
                  )
                ],
              ))
            ],
          ),
        ));
  }
}
