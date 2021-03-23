import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_checklist/data/AppDatabase.dart';
import 'package:shopping_checklist/themes/darkTheme.dart';
import 'package:shopping_checklist/themes/lightTheme.dart';
import 'package:shopping_checklist/ui/checklist.dart';
import 'package:shopping_checklist/widgets/DrawerStateInfo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = AppDatabase();

    //is the current app theme the dark one
    bool isDarkTheme;

    SharedPreferences.getInstance().then(
      (prefs) => {
        isDarkTheme = prefs.getBool('darkTheme') ?? true,
      },
    );

    return MultiProvider(
      providers: [
        Provider(create: (_) => db.itemDao),
        Provider(create: (_) => db.presetDao),
        Provider(create: (_) => db.setItemDao),
        ChangeNotifierProvider<DrawerStateInfo>(
            create: (_) => DrawerStateInfo())
      ],
      child: MaterialApp(
        theme: isDarkTheme ? darkTheme : lightTheme,
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
