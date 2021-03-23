import 'package:flutter/material.dart';

//credit to
// https://betterprogramming.pub/how-to-create-a-dynamic-theme-in-flutter-using-provider-e6ad1f023899

final ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.blue,
  brightness: Brightness.light,
  backgroundColor: Colors.white,
  accentColor: Colors.blue,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: Colors.white,
      backgroundColor: Colors.blue,
    ),
  ),
  dividerColor: Colors.white54,
);
