import 'package:flutter/material.dart';
import 'package:my_news_app/helper/constants.dart';
import 'package:my_news_app/pages/loginScreen.dart';
import 'package:my_news_app/pages/newsApp.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

User loggedInUser;

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  Widget navigate;
  User currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    if (currentUser != null) {
      navigate = NewsApp();
    } else {
      navigate = LoginScreen();
    }
    return SplashScreen(
        seconds: 2,
        navigateAfterSeconds: navigate,
        title: Text(
          'News App',
          style: kAppbarText,
        ),
        image: Image.asset('images/logo.png'),
        backgroundColor: Colors.black,
        styleTextUnderTheLoader: TextStyle(),
        photoSize: 180.0,
        loaderColor: Colors.teal);
  }
}
