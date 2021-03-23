import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var currentTheme;
  List<Color> lightPriorityColors;
  List<Color> darkPriorityColors;

  void _loadThemeData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    currentTheme = (prefs.getBool('darkTheme') ?? true);
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

    //TODO: theme swap
    //TRY: allow theme color change
    //TODO: priority color changer
    //TODO: priority colors per theme
    //TODO: time to move checked items to History
    //TODO: how long to keep oldest item in history
    //TODO LAST: about dev
    throw UnimplementedError();
  }
}
