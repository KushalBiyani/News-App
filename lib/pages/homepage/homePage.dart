import 'package:flutter/material.dart';
import 'package:my_news_app/theme/theme.dart';

import 'newsCard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _headerNews() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Hero(
          tag: 'headerImage',
          child: Image.network(
              'https://www.channelnomics.com/wp-content/uploads/2019/04/surface-Hub-2s-770x515.jpg'),
        ),
        Container(
          padding: EdgeInsets.only(left: 30, right: 40, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Managing your workspace to more comfort',
                  style: AppTheme.h1Style
                      .copyWith(color: Theme.of(context).backgroundColor)),
              Text('17 December 2019',
                  style: AppTheme.subTitleStyle
                      .copyWith(color: Theme.of(context).backgroundColor))
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            centerTitle: true,
            title: Text(
              'NEWS',
              style: AppTheme.h2Style.copyWith(
                  color: Theme.of(context).colorScheme.primaryVariant),
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: _headerNews(),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              NewsCard(),
              NewsCard(),
              NewsCard(),
              NewsCard(),
              NewsCard(),
              NewsCard(),
              NewsCard(),
            ]),
          )
        ],
      ),
    ));
  }
}
