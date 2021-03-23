import 'package:flutter/material.dart';

//credit to
// https://betterprogramming.pub/how-to-create-a-dynamic-theme-in-flutter-using-provider-e6ad1f023899

final ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.grey[800],
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: Colors.grey[400],
  toggleableActiveColor: Colors.blue,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: Colors.black,
      backgroundColor: Colors.grey[400],
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Colors.black,
    backgroundColor: Colors.grey[600],
  ),
  dividerColor: Colors.black12,
);
