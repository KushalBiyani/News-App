import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_news_app/helper/constants.dart';

Image customImage(String path,
    {BoxFit fit = BoxFit.contain, bool asset = false}) {
  return Image(
    image:
        asset ? AssetImage('images/' + path) : customAdvanceNetworkImage(path),
    fit: fit,
    loadingBuilder:
        (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
      if (loadingProgress == null) return child;
      return Center(
        child: CircularProgressIndicator(),
      );
    },
    frameBuilder: (BuildContext context, Widget child, int frame,
        bool wasSynchronouslyLoaded) {
      if (wasSynchronouslyLoaded ?? false) {
        return child;
      }
      return AnimatedOpacity(
        child: child,
        opacity: frame == null ? 0 : 1,
        duration: const Duration(seconds: 2),
        curve: Curves.easeOut,
      );
    },
    errorBuilder: (context, url, error) => Image.asset('images/noImage.jpg'),
  );
}

dynamic customAdvanceNetworkImage(String path) {
  return CachedNetworkImageProvider(
    path,
  );
}

Widget buildAppBar(String type) {
  type = type == null ? "" : type.toUpperCase();
  return SliverAppBar(
    centerTitle: true,
    leading: Container(),
    title: Text(
      '$type NEWS',
      style: kAppbarText,
    ),
    backgroundColor: Colors.black,
    pinned: true,
  );
}

Widget normalAppBar(String text) {
  return AppBar(
    leading: Container(),
    title: Text(
      text,
      style: kAppbarText,
    ),
    centerTitle: true,
    backgroundColor: Colors.black,
  );
}
