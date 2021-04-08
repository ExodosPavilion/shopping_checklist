import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_checklist/constants.dart';
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
    defaultPreferencesSet = prefs.getBool(kDefaultPreferencesSet) ?? false;

    if (!defaultPreferencesSet) {
      defaultPreferencesSet = _setDefaults();
    }

    var isDarkTheme = prefs.getBool(kIsDarkTheme) ?? true;

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
      prefs.setBool(kIsDarkTheme, (brightness == Brightness.dark)),
      //
      prefs.setInt(kDarkHighPriority, kDefaultDarkHighPriority.value),
      prefs.setInt(kDarkMediumPriority, kDefaultDarkMediumPriority.value),
      prefs.setInt(kDarkLowPriority, kDefaultDarkLowPriority.value),
      //
      prefs.setInt(kLightHighPriority, kDefaultlightHighPriority.value),
      prefs.setInt(kLightMediumPriority, kDefaultlightMediumPriority.value),
      prefs.setInt(kLightLowPriority, kDefaultlightLowPriority.value),
      //
      prefs.setInt(kSortOrder, kDefSortOrder),
      prefs.setInt(kTimeIntervalCheckToHistory, kDefCheckToHistoryTimeInterval),
      prefs.setBool(kDefaultPreferencesSet, true)
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
        Provider(create: (_) => db.historyItemDao),
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
