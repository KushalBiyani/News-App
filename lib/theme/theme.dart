import 'dart:ui';
import 'package:flutter/material.dart';
import 'lightColor.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    backgroundColor: LightColor.background,
    primaryColor: LightColor.teal,
    accentColor: LightColor.lightblack,
    primaryColorDark: LightColor.Darker,
    primaryColorLight: LightColor.brighter,
    cardTheme: CardTheme(color: LightColor.background),
    textTheme: TextTheme(headline4: TextStyle(color: LightColor.black)),
    iconTheme: IconThemeData(color: LightColor.lightblack),
    colorScheme: ColorScheme(
        primary: LightColor.teal,
        primaryVariant: LightColor.teal,
        secondary: LightColor.lightBlue,
        secondaryVariant: LightColor.darkBlue,
        surface: LightColor.background,
        background: LightColor.background,
        error: Colors.red,
        onPrimary: LightColor.Darker,
        onSecondary: LightColor.Darker,
        onSurface: LightColor.titleTextColor,
        onBackground: LightColor.titleTextColor,
        onError: LightColor.titleTextColor,
        brightness: Brightness.dark),
  );

  static TextStyle titleStyle =
      const TextStyle(color: LightColor.titleTextColor, fontSize: 16);
  static TextStyle subTitleStyle =
      const TextStyle(color: LightColor.subTitleTextColor, fontSize: 12);

  static TextStyle h1Style = const TextStyle(
      color: LightColor.titleTextColor,
      fontSize: 24,
      fontWeight: FontWeight.bold);
  static TextStyle h2Style =
      const TextStyle(color: LightColor.titleTextColor, fontSize: 22);
  static TextStyle h3Style =
      const TextStyle(color: LightColor.titleTextColor, fontSize: 20);
  static TextStyle h4Style =
      const TextStyle(color: LightColor.titleTextColor, fontSize: 18);
  static TextStyle h5Style =
      const TextStyle(color: LightColor.titleTextColor, fontSize: 16);
  static TextStyle h6Style =
      const TextStyle(color: LightColor.titleTextColor, fontSize: 14);
}
