import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_checklist/changeNotifiers/ThemeNotifier.dart';
import 'package:shopping_checklist/constants.dart';
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
  bool _moveCheckedImmediately = true;
  bool _useCardStyle = false;
  bool _usePrioritySystem = false;

  int _intervalAmount = 0;
  List<int> hourIntervals = [for (int i = 0; i < 25; i += 1) i];

  int _numOfMonths = 1;
  List<int> monthIntervals = [for (int i = 1; i < 13; i += 1) i];

  List<Color> lightPriorityColors;
  List<Color> darkPriorityColors;

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) {
    (value)
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
    SharedPreferences.getInstance().then(
      (prefs) => prefs.setBool(kIsDarkTheme, value),
    );
  }

  void _setLightPriorityColors() {
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setInt(kLightHighPriority, lightPriorityColors[0].value);
        prefs.setInt(kLightMediumPriority, lightPriorityColors[1].value);
        prefs.setInt(kLightLowPriority, lightPriorityColors[2].value);
      },
    );
  }

  void _setDarkPriorityColors() {
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setInt(kDarkHighPriority, darkPriorityColors[0].value);
        prefs.setInt(kDarkMediumPriority, darkPriorityColors[1].value);
        prefs.setInt(kDarkLowPriority, darkPriorityColors[2].value);
      },
    );
  }

  void _setListStyle() {
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool(kUseCardStyle, _useCardStyle);
      },
    );
  }

  void _setPriorityBool() {
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool(kpriorityBool, _usePrioritySystem);
      },
    );
  }

  void _setMoveToHistoryTimeInterval() {
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setInt(kTimeIntervalCheckToHistory, _intervalAmount);
      },
    );
  }

  void _setDeleteFromHistoryTimeInterval() {
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setInt(kTimeIntervalHistoryDeletion, _numOfMonths);
      },
    );
  }

  void _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    _isDarkMode = (prefs.getBool(kIsDarkTheme) ?? true);

    darkPriorityColors = [
      Color(prefs.getInt(kDarkHighPriority) ?? kDefaultDarkHighPriority.value),
      Color(prefs.getInt(kDarkMediumPriority) ??
          kDefaultDarkMediumPriority.value),
      Color(prefs.getInt(kDarkLowPriority) ?? kDefaultDarkLowPriority.value),
    ];

    lightPriorityColors = [
      Color(
          prefs.getInt(kLightHighPriority) ?? kDefaultlightHighPriority.value),
      Color(prefs.getInt(kLightMediumPriority) ??
          kDefaultlightMediumPriority.value),
      Color(prefs.getInt(kLightLowPriority) ?? kDefaultlightLowPriority.value),
    ];

    _useCardStyle = (prefs.getBool(kUseCardStyle) ?? false);

    _intervalAmount = prefs.getInt(kTimeIntervalCheckToHistory) ??
        kDefCheckToHistoryTimeInterval;
    _numOfMonths = prefs.getInt(kTimeIntervalHistoryDeletion) ??
        kDefHistoryClearTimeIntercal;

    _usePrioritySystem = (prefs.getBool(kpriorityBool) ?? false);

    if (_intervalAmount == 0) {
      _moveCheckedImmediately = true;
    } else {
      _moveCheckedImmediately = false;
    }

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
              title: Text(kSettingsScreen),
              //actions: [IconButton(icon: Icon(Icons.menu), onPressed: _navbar),], //used to get a navbar on the right (not what we need, lookup: drawer)
            ),
            drawer:
                AppDrawer(kSettingsScreen), //Creates the floating action button
            body: _buildList(context),
          );
  }

  Widget _buildList(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    _isDarkMode = (themeNotifier.getTheme() == darkTheme);

    //TRY: allow theme color change
    //TRY: priority colors per theme

    final List<Widget> widgetChildren = [
      _buildCard(
        kDarkModeSwitchTitle,
        hasToggleWidget: true,
        isSwitch: true,
        toggleValue: _isDarkMode,
        toggleText: kDarkModeSwtichText,
        toggledFunction: _darkModeSwitchFunc,
      ),
      _buildCard(
        kUseCardStyleSwitchTitle,
        hasToggleWidget: true,
        isSwitch: true,
        toggleValue: _useCardStyle,
        toggleText: kUseCardStyleSwitchText,
        toggledFunction: _cardStyleSwitchFunc,
      ),
      _buildCard(
        kUsePrioritySystemSwitchTitle,
        hasToggleWidget: true,
        isSwitch: true,
        warning: kUsePrioritySystemwarningText,
        toggleValue: _usePrioritySystem,
        toggleText: kUsePrioritySystemSwitchText,
        toggledFunction: _usePrioritySystemSwitchFunc,
      ),
    ];

    if (_usePrioritySystem) {
      widgetChildren.add(
        _buildCard(
          kPriorityColorChangerTitle,
          hasOwnWidgets: true,
          listOfWidgetsToUse: [
            _buildListTile(kPriorityColorChangerHigh, 0),
            _buildListTile(kPriorityColorChangerMedium, 1),
            _buildListTile(kPriorityColorChangerLow, 2),
          ],
        ),
      );
    }

    widgetChildren.add(
      _buildCard(
        kChecklistToHistoryCardTitle,
        isSwitch: false,
        toggleValue: _moveCheckedImmediately,
        toggledFunction: _checkedToHistoryCheckBoxFunc,
        warning: kChecklistToHistoryCardWarning,
        toggleText: kChecklistToHistoryCardCheckTitle,
        intervalTitle: kChecklistToHistoryCardDropDownTitle,
        intervals: hourIntervals,
        intervalValue: _intervalAmount,
        intervalItemtext: kChecklistToHistoryCardDropDownItemText,
        intervalChangedFunction: _checkedToHistoryDropDownFunc,
      ),
    );
    widgetChildren.add(
      _buildCard(
        kHistoryDeleteCardTitle,
        hasToggleWidget: false,
        warning: kHistoryDeleteCardWarning,
        intervalTitle: kHistoryDeleteCardDropDownTitle,
        intervals: monthIntervals,
        intervalValue: _numOfMonths,
        intervalItemtext: kHistoryDeleteCardDropDownITem,
        intervalChangedFunction: _historyDeleteDropDownFunc,
      ),
    );

    return ListView(
      children: widgetChildren,
    );
  }

  _buildListTile(String tileTitle, int index) {
    return Card(
      child: ListTile(
        title: Text(
          tileTitle,
          style: TextStyle(color: Colors.black),
        ),
        trailing: Icon(
          Icons.palette,
          color: Colors.black,
        ),
        tileColor: _isDarkMode
            ? darkPriorityColors[index]
            : lightPriorityColors[index],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        onTap: () {
          _colorPickerPopup(index);
        },
      ),
    );
  }

  _buildCard(
    String title, {
    bool hasToggleWidget = true,
    bool hasOwnWidgets = false,
    List<Widget> listOfWidgetsToUse,
    bool isSwitch = false,
    bool toggleValue = false,
    Function toggledFunction,
    String warning = '',
    String toggleText = '',
    String intervalTitle = '',
    List<int> intervals,
    int intervalValue,
    String intervalItemtext = '',
    Function intervalChangedFunction,
  }) {
    List<Widget> _widgetsForCard = [
      Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      Divider(),
    ];

    if (hasOwnWidgets) {
      if (listOfWidgetsToUse != null || listOfWidgetsToUse != []) {
        for (Widget widget in listOfWidgetsToUse) {
          _widgetsForCard.add(widget);
        }
      }
    } else {
      if (warning != '') {
        _widgetsForCard.add(
          Text(
            warning,
            style: TextStyle(color: Colors.red, fontSize: 12),
          ),
        );
        _widgetsForCard.add(
          Divider(),
        );
      }

      if (hasToggleWidget) {
        if (isSwitch) {
          _widgetsForCard.add(
            SwitchListTile(
              title: Text(toggleText),
              value: toggleValue,
              onChanged: (value) => toggledFunction(value),
            ),
          );
        } else {
          _widgetsForCard.add(
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  toggleText,
                  style: TextStyle(fontSize: 16),
                ),
                Checkbox(
                  value: toggleValue,
                  onChanged: (value) => toggledFunction(value),
                )
              ],
            ),
          );
        }
      }

      if (intervalTitle != '') {
        _widgetsForCard.add(
          Visibility(
            visible: !toggleValue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  intervalTitle,
                  style: TextStyle(fontSize: 16),
                ),
                DropdownButton(
                  value: intervalValue,
                  items: intervals.map((int val) {
                    return DropdownMenuItem(
                      child: Text(val.toString() + intervalItemtext),
                      value: val,
                    );
                  }).toList(),
                  onChanged: (value) => intervalChangedFunction(value),
                ),
              ],
            ),
          ),
        );
      }
    }

    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: _widgetsForCard,
        ),
      ),
    );
  }

  _darkModeSwitchFunc(bool newVal) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    setState(
      () {
        _isDarkMode = newVal;
      },
    );
    onThemeChanged(newVal, themeNotifier);
  }

  _cardStyleSwitchFunc(bool newVal) {
    setState(
      () {
        _useCardStyle = newVal;
      },
    );
    _setListStyle();
  }

  _usePrioritySystemSwitchFunc(bool newVal) {
    setState(
      () {
        _usePrioritySystem = newVal;
      },
    );
    _setPriorityBool();
  }

  _checkedToHistoryCheckBoxFunc(bool newVal) {
    setState(
      () {
        _moveCheckedImmediately = newVal;

        if (_moveCheckedImmediately) {
          _intervalAmount = 0;
          _setMoveToHistoryTimeInterval();
        }
      },
    );
  }

  _checkedToHistoryDropDownFunc(int newVal) {
    _setMoveToHistoryTimeInterval();
    setState(() {
      _intervalAmount = newVal;
    });
  }

  _historyDeleteDropDownFunc(int newVal) {
    _setDeleteFromHistoryTimeInterval();
    setState(
      () {
        _numOfMonths = newVal;
      },
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
          title: Text(kColorPickerDialogTitle),
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
                            color: _isDarkMode
                                ? val[kDarkPriorityColorShade]
                                : val[kLightPriorityColorShade],
                          ),
                          onPressed: () {
                            darkPriorityColors[index] =
                                val[kDarkPriorityColorShade];
                            lightPriorityColors[index] =
                                val[kLightPriorityColorShade];
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
