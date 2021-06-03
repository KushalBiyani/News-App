import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebView extends StatefulWidget {
  final String url;
  NewsWebView({Key key, this.url}) : super(key: key);
  @override
  NewsWebViewState createState() => NewsWebViewState(url);
}

class NewsWebViewState extends State<NewsWebView> {
  final String url;
  NewsWebViewState(this.url);
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Web View'),
        backgroundColor: Colors.black,
      ),
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}
