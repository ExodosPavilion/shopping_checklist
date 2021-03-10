import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_checklist/data/AppDatabase.dart';
import 'package:shopping_checklist/ui/checklist.dart';
import 'package:shopping_checklist/ui/presets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => AppDatabase().itemDao,
      child: MaterialApp(
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
      ),
    );
  }
}
