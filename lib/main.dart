import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_checklist/data/AppDatabase.dart';
import 'package:shopping_checklist/themes/darkTheme.dart';
import 'package:shopping_checklist/themes/lightTheme.dart';
import 'package:shopping_checklist/ui/checklist.dart';
import 'package:shopping_checklist/changeNotifiers/DrawerStateInfo.dart';

import 'changeNotifiers/ThemeNotifier.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  var defaultPreferencesSet = false;

  SharedPreferences.getInstance().then((prefs) {
    defaultPreferencesSet = prefs.getBool('defaultPreferencesSet') ?? false;

    if (!defaultPreferencesSet) {
      defaultPreferencesSet = _setDefaults();
    }

    var isDarkTheme = prefs.getBool('darkTheme') ?? true;

    runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (_) => ThemeNotifier(isDarkTheme ? darkTheme : lightTheme),
        child: MyApp(),
      ),
    );
  });
}

bool _setDefaults() {
  var brightness = SchedulerBinding.instance.window.platformBrightness;

  SharedPreferences.getInstance().then(
    (prefs) => {
      prefs.setBool('darkTheme', (brightness == Brightness.dark)),
      prefs.setInt('highPriority', Colors.red.value),
      prefs.setInt('mediumPriority', Colors.orange.value),
      prefs.setInt('lowPriority', Colors.yellow.value),
      prefs.setInt('sortOrder', 2),
      prefs.setBool('defaultPreferencesSet', true)
    },
  );

  return true;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = AppDatabase();

    return MultiProvider(
      providers: [
        Provider(create: (_) => db.itemDao),
        Provider(create: (_) => db.presetDao),
        Provider(create: (_) => db.setItemDao),
        ChangeNotifierProvider<DrawerStateInfo>(
          create: (_) => DrawerStateInfo(),
        ),
      ],
      child: MaterialApp(
        theme: Provider.of<ThemeNotifier>(context).getTheme(),
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
