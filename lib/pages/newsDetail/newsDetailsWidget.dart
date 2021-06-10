import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_news_app/helper/constants.dart';
import 'package:my_news_app/helper/firebaseHelper.dart';
import 'package:my_news_app/helper/shareNews.dart';
import 'package:my_news_app/model/newsResponseModel.dart';
import 'package:my_news_app/pages/NewsWebView.dart';
import 'package:my_news_app/widgets/customWidget.dart';

class NewsDetailWidget extends StatefulWidget {
  final Article article;

  const NewsDetailWidget({Key key, this.article}) : super(key: key);
  @override
  _NewsDetailWidgetState createState() => _NewsDetailWidgetState(article);
}

class _NewsDetailWidgetState extends State<NewsDetailWidget> {
  User currentUser = FirebaseAuth.instance.currentUser;
  final Article article;
  bool present = false;
  bool loading = false;

  _NewsDetailWidgetState(this.article);
  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
    updatePresent();
  }

  void updatePresent() async {
    bool pre = await checkPresent(article.url);
    setState(() {
      present = pre;
      loading = false;
    });
  }

  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              actions: [
                IconButton(
                  onPressed: () async {
                    if (!present) {
                      addsaved(article);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Added to Saved News"),
                      ));
                      setState(() {
                        present = !present;
                      });
                    } else {
                      deleteItem(article.url);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Removed From Saved News"),
                      ));
                      setState(() {
                        present = !present;
                      });
                    }
                  },
                  icon: Icon(
                    present
                        ? Icons.bookmark_sharp
                        : Icons.bookmark_outline_sharp,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
                IconButton(
                  onPressed: () => shareNews(article),
                  icon: Icon(
                    Icons.share,
                    color: Colors.white,
                    size: 32,
                  ),
                )
              ],
            ),
            backgroundColor: kBackgroundColor,
            body: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Hero(
                    tag: 'headerImage',
                    child:
                        article.urlToImage == null || article.urlToImage.isEmpty
                            ? Container()
                            : customImage(article.urlToImage),
                  ),
                ),
                SliverToBoxAdapter(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Text(article.title, style: kh1Style),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            article.author ?? '',
                            style: kh6Style,
                          ),
                          SizedBox(width: 10),
                          article.publishedAt == null
                              ? Container()
                              : Text(article.getTime(), style: kh5Style),
                        ],
                      ),
                      Divider(height: 20, thickness: 2),
                      Text(
                        article.content != null
                            ? article.content.substring(0, 200)
                            : '',
                        style: kh5Style,
                        overflow: TextOverflow.visible,
                      ),
                      SizedBox(height: 20),
                      article.url != null
                          ? InkWell(
                              child: Text(
                                'Full Article at >>',
                                style: kh4Style.copyWith(
                                    color: Colors.teal,
                                    decoration: TextDecoration.underline),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NewsWebView(url: article.url)));
                              })
                          : Container()
                    ],
                  ),
                ))
              ],
            ),
          );
  }
}
