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
  bool isLoaded = false;
  bool _isDarkMode = true;
  List<Color> lightPriorityColors;
  List<Color> darkPriorityColors;

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) {
    (value)
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
    SharedPreferences.getInstance().then(
      (prefs) => prefs.setBool('darkTheme', value),
    );
  }

  void _setLightPriorityColors() {
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setInt('lightHighPriority', lightPriorityColors[0].value);
        prefs.setInt('lightMediumPriority', lightPriorityColors[1].value);
        prefs.setInt('lightLowPriority', lightPriorityColors[2].value);
      },
    );
  }

  void _setDarkPriorityColors() {
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setInt('DarkHighPriority', darkPriorityColors[0].value);
        prefs.setInt('DarkMediumPriority', darkPriorityColors[1].value);
        prefs.setInt('DarkLowPriority', darkPriorityColors[2].value);
      },
    );
  }

  void _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    _isDarkMode = (prefs.getBool('darkTheme') ?? true);

    darkPriorityColors = [
      Color(prefs.getInt('DarkHighPriority') ?? Colors.red.value),
      Color(prefs.getInt('DarkMediumPriority') ?? Colors.orange.value),
      Color(prefs.getInt('DarkLowPriority') ?? Colors.yellow.value),
    ];

    lightPriorityColors = [
      Color(prefs.getInt('lightHighPriority') ?? Colors.red[400].value),
      Color(prefs.getInt('lightMediumPriority') ?? Colors.orange[400].value),
      Color(prefs.getInt('lightLowPriority') ?? Colors.yellow[400].value),
    ];

    isLoaded = true;

    setState(() {});
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !isLoaded
        ? CircularProgressIndicator()
        : Scaffold(
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
    //TRY: priority colors per theme
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
        ),
        ListTile(
          title: Text(
            'High Priority',
            style: TextStyle(color: Colors.black),
          ),
          trailing: Icon(
            Icons.palette,
            color: Colors.black,
          ),
          tileColor:
              _isDarkMode ? darkPriorityColors[0] : lightPriorityColors[0],
          onTap: () {
            _colorPickerPopup(0);
          },
        ),
        ListTile(
          title: Text(
            'Medium Priority',
            style: TextStyle(color: Colors.black),
          ),
          trailing: Icon(
            Icons.palette,
            color: Colors.black,
          ),
          tileColor:
              _isDarkMode ? darkPriorityColors[1] : lightPriorityColors[1],
          onTap: () {
            _colorPickerPopup(1);
          },
        ),
        ListTile(
          title: Text(
            'Low Priority',
            style: TextStyle(color: Colors.black),
          ),
          trailing: Icon(
            Icons.palette,
            color: Colors.black,
          ),
          tileColor:
              _isDarkMode ? darkPriorityColors[2] : lightPriorityColors[2],
          onTap: () {
            _colorPickerPopup(2);
          },
        ),
      ],
    );
  }

  _colorPickerPopup(int index) {
    List<MaterialColor> _availableColors = [
      Colors.pink,
      Colors.red,
      Colors.deepOrange,
      Colors.orange,
      Colors.amber,
      Colors.yellow,
      Colors.lime,
      Colors.lightGreen,
      Colors.green,
      Colors.teal,
      Colors.cyan,
      Colors.lightBlue,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
      Colors.deepPurple,
      Colors.brown,
      Colors.blueGrey,
      Colors.grey,
    ];

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Pick a Color'),
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .8, //80% of the screen
              height:
                  MediaQuery.of(context).size.width * .7, //70% of the screen
              child: GridView.count(
                  crossAxisCount: 5,
                  children: _availableColors.map(
                    (MaterialColor val) {
                      return new GridTile(
                        child: IconButton(
                          icon: Icon(
                            Icons.circle,
                            color: _isDarkMode ? val : val[400],
                          ),
                          onPressed: () {
                            darkPriorityColors[index] = val;
                            lightPriorityColors[index] = val[400];
                            _setDarkPriorityColors();
                            _setLightPriorityColors();
                            setState(() {});
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  ).toList()),
            )
          ],
        );
      },
    );
  }
}
