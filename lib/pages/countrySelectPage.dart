import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_news_app/helper/constants.dart';
import 'package:flag/flag.dart';
import 'package:my_news_app/pages/homepage/bloc/bloc.dart';
import 'package:my_news_app/widgets/bloc/bloc.dart';
import 'package:my_news_app/widgets/customWidget.dart';

class CountrySelectPage extends StatefulWidget {
  final PageController controller;
  CountrySelectPage({Key key, this.controller}) : super(key: key);
  @override
  _CountrySelectPageState createState() => _CountrySelectPageState();
}

class _CountrySelectPageState extends State<CountrySelectPage> {
  Widget _countryCard(
    String text,
    String code,
  ) {
    return InkWell(
      onTap: () {
        BlocProvider.of<NewsBloc>(context).add(Fetch(country: code));
        BlocProvider.of<NavigationBloc>(context).add(Navigate(pageIndex: 0));
        widget.controller.animateTo(0,
            duration: Duration(milliseconds: 300), curve: Curves.linear);
      },
      child: Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.4,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Flag(
                  code.toUpperCase(),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Text(text, style: kh4Style.copyWith(fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

  List<Widget> getList() {
    List<Widget> childs = [];
    for (var i = 0; i < listOfCountry.length; i++) {
      childs.add(
          _countryCard(listOfCountry[i]["name"], listOfCountry[i]["code"]));
    }
    return childs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: normalAppBar("Select Country"),
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverGrid.count(
              childAspectRatio: 1,
              mainAxisSpacing: 0,
              crossAxisCount: 3,
              children: getList(),
            ),
          ],
        ),
      ),
    );
  }
}
