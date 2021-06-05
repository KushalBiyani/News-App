import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_news_app/helper/constants.dart';

// Widget customText(String msg,
//     {TextStyle style,
//     TextAlign textAlign = TextAlign.justify,
//     overflow = TextOverflow.clip,
//     BuildContext context}) {
//   if (msg == null) {
//     return SizedBox(
//       height: 0,
//       width: 0,
//     );
//   } else {
//     if (context != null && style != null) {
//       var fontSize =
//           style.fontSize ?? Theme.of(context).textTheme.body1.fontSize;
//       style = style.copyWith(
//           fontSize: fontSize - (fullWidth(context) <= 375 ? 2 : 0));
//     }
//     return Text(
//       msg,
//       style: style,
//       textAlign: textAlign,
//       overflow: overflow,
//     );
//   }
// }

double fullWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double fullHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double getDimention(context, double unit) {
  if (fullWidth(context) <= 360.0) {
    return unit / 1.3;
  } else {
    return unit;
  }
}

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
    title: Text(
      '$type NEWS',
      style: kAppbarText,
    ),
    backgroundColor: Colors.black,
    pinned: true,
  );
}
