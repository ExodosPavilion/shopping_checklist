import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_checklist/changeNotifiers/ThemeNotifier.dart';
import 'package:shopping_checklist/themes/darkTheme.dart';
import 'package:shopping_checklist/themes/lightTheme.dart';
import 'package:shopping_checklist/widgets/AppDrawer.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _isDarkMode = true;
  List<Color> lightPriorityColors;
  List<Color> darkPriorityColors;

  void _loadThemeData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = (prefs.getBool('darkTheme') ?? true);
  }

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) {
    (value)
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
    SharedPreferences.getInstance().then(
      (prefs) => prefs.setBool('darkTheme', value),
    );
  }

  void _loadLightPriorityColors() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int highPriority = (prefs.getInt('highPriority') ?? Colors.red[300].value);
    int mediumPriority =
        (prefs.getInt('mediumPriority') ?? Colors.orange[300].value);
    int lowPriority = (prefs.getInt('lowPriority') ?? Colors.yellow[300].value);

    lightPriorityColors = [
      Color(highPriority),
      Color(mediumPriority),
      Color(lowPriority),
    ];
  }

  void _loadDarkPriorityColors() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int highPriority = (prefs.getInt('highPriority') ?? Colors.red.value);
    int mediumPriority =
        (prefs.getInt('mediumPriority') ?? Colors.orange.value);
    int lowPriority = (prefs.getInt('lowPriority') ?? Colors.yellow.value);

    darkPriorityColors = [
      Color(highPriority),
      Color(mediumPriority),
      Color(lowPriority),
    ];
  }

  void _loadData() {
    _loadThemeData();
    _loadLightPriorityColors();
    _loadDarkPriorityColors();
  }

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    _loadData();

    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping CheckList'),
        //actions: [IconButton(icon: Icon(Icons.menu), onPressed: _navbar),], //used to get a navbar on the right (not what we need, lookup: drawer)
      ),
      drawer: AppDrawer("Settings"), //Creates the floating action button
      body: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _isDarkMode = (themeNotifier.getTheme() == darkTheme);

    //TRY: allow theme color change
    //TODO: priority color changer
    //TODO: priority colors per theme
    //TODO: time to move checked items to History
    //TODO: how long to keep oldest item in history
    //TODO LAST: about dev

    return ListView(
      children: [
        SwitchListTile(
          title: Text('Dark Mode'),
          value: _isDarkMode,
          onChanged: (bool value) {
            setState(
              () {
                _isDarkMode = value;
              },
            );
            onThemeChanged(value, themeNotifier);
          },
        )
      ],
    );
  }
}
