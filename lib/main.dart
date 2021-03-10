import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_checklist/data/AppDatabase.dart';
import 'package:shopping_checklist/ui/checklist.dart';
import 'package:shopping_checklist/ui/itemGroup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = AppDatabase();

    return MultiProvider(
      providers: [
        Provider(create: (_) => db.itemDao),
        Provider(create: (_) => db.presetDao),
        Provider(create: (_) => db.setItemDao),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.blue, //The primary color used by the app
        ),
        home: Scaffold(
          body: Center(
            child: ItemGroup(), //CheckList class that builds the main app page
          ),
        ),
        debugShowCheckedModeBanner:
            false, //Needed to stop the debug banner from showing
      ),
    );
  }
}
