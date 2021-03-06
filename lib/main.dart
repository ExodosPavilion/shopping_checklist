import 'package:flutter/material.dart';
import 'package:shopping_checklist/checklist.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue, //The primary color used by the app
      ),
      home: Scaffold(
        body: Center(
          child: CheckList(), //CheckList class that builds the main app page
        ),
      ),
      debugShowCheckedModeBanner:
          false, //Needed to stop the debug banner from showing
    );
  }
}
