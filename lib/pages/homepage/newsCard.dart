import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_news_app/pages/newsDetail/bloc/bloc.dart';
import 'package:my_news_app/helper/constants.dart';
import 'package:my_news_app/widgets/customWidget.dart';
import 'package:my_news_app/model/newsResponseModel.dart';

class NewsCard extends StatelessWidget {
  final Article artical;
  final String type;
  const NewsCard({Key key, this.artical, this.type = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<DetailBloc>(context)
            .add(SelectNewsForDetail(article: artical));
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
                child: Container(
                  child:
                      artical.urlToImage == null || artical.urlToImage.isEmpty
                          ? Container()
                          : customImage(artical.urlToImage, fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  height: 65,
                  child: Text(
                    artical.title,
                    style: kh6Style,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.teal,
                      ),
                      child: Text(
                        type.length < 2 ? 'General' : "$type",
                        style: type.length > 10
                            ? kh5Style
                            : kh4Style.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        artical.getDateOnly().substring(0, 8),
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
