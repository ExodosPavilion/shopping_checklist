import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_checklist/data/AppDatabase.dart';
import 'package:shopping_checklist/widgets/AppDrawer.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  bool isDarkTheme = true;

  List<Color> priorityColors;

  LinkedHashMap<String, List<HistoryItem>> _historyData =
      LinkedHashMap<String, List<HistoryItem>>();

  void _loadThemeData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkTheme = (prefs.getBool('darkTheme') ?? true);
  }

  void _loadLightPriorityColors() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int highPriority =
        (prefs.getInt('lightHighPriority') ?? Colors.red[400].value);
    int mediumPriority =
        (prefs.getInt('lightMediumPriority') ?? Colors.orange[400].value);
    int lowPriority =
        (prefs.getInt('lightLowPriority') ?? Colors.yellow[400].value);

    priorityColors = [
      Color(highPriority),
      Color(mediumPriority),
      Color(lowPriority),
    ];
  }

  void _loadDarkPriorityColors() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int highPriority = (prefs.getInt('DarkHighPriority') ?? Colors.red.value);
    int mediumPriority =
        (prefs.getInt('DarkMediumPriority') ?? Colors.orange.value);
    int lowPriority = (prefs.getInt('DarkLowPriority') ?? Colors.yellow.value);

    priorityColors = [
      Color(highPriority),
      Color(mediumPriority),
      Color(lowPriority),
    ];
  }

  void _loadData() {
    _loadThemeData();

    if (isDarkTheme) {
      _loadDarkPriorityColors();
    } else {
      _loadLightPriorityColors();
    }
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
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: _addTestData,
          ),
          IconButton(
            icon: Icon(Icons.remove_circle_outline),
            onPressed: _deleteAll,
          ),
        ],
      ),
      drawer: AppDrawer("History"), //Creates the floating action button
      body: _getDataAndList(context),
    );
  }

  _getDataAndList(BuildContext context) {
    final dao = Provider.of<HistoryItemDao>(context);

    return StreamBuilder(
      stream: dao.watchHistoryItemsbyDateDesc(),
      builder: (context, AsyncSnapshot<List<HistoryItem>> snapshot) {
        final items = snapshot.data ?? [];

        return ListView(
          children: _buildList(context, items),
        );
      },
    );
  }

  _buildList(BuildContext context, List<HistoryItem> items) {
    List<Widget> returnList = [];

    if (items != null) {
      for (HistoryItem historyItem in items) {
        String keyForItem = _returnDateString(historyItem.checkedTime);

        if (_historyData.containsKey(keyForItem)) {
          if (!_historyData[keyForItem].contains(historyItem)) {
            _historyData[keyForItem].add(historyItem);
          }
        } else {
          _historyData[keyForItem] = [historyItem];
        }
      }

      if (_historyData != {}) {
        _historyData.forEach(
          (key, value) {
            returnList.add(
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 5.0, left: 10.0),
                child: Text(
                  key,
                  style: TextStyle(
                    fontSize: 25,
                    shadows: [
                      Shadow(
                          color: isDarkTheme ? Colors.white : Colors.black,
                          offset: Offset(0, -5))
                    ],
                    color: Colors.transparent,
                    decoration: TextDecoration.underline,
                    decorationColor: isDarkTheme ? Colors.white : Colors.black,
                    decorationThickness: 4,
                  ),
                ),
              ),
            );
            for (HistoryItem historyItem in value) {
              returnList.add(_buildRow(context, historyItem));
            }
          },
        );
      }
    }

    if (returnList == null) {
      returnList = [Icon(Icons.sentiment_dissatisfied)];
    }

    return returnList;
  }

  _buildRow(BuildContext context, HistoryItem historyItem) {
    return ListTile(
      title: Text(
        historyItem.item,
        style: TextStyle(color: Colors.black),
      ),
      subtitle: Text(
        historyItem.checkedTime.toString(),
        style: TextStyle(color: Colors.black),
      ),
      tileColor: historyItem.priority == 0
          ? priorityColors[2]
          : historyItem.priority == 1
              ? priorityColors[1]
              : priorityColors[0],
    );
  }

  String _returnDateString(DateTime dateData) {
    return dateData.day.toString() +
        '-' +
        dateData.month.toString() +
        '-' +
        dateData.year.toString();
  }

  void _deleteAll() async {
    final dao = AppDatabase().historyItemDao;
    final List<HistoryItem> historyItems = await dao.getHistoryItemsbyDate();

    for (int i = 0; i < historyItems.length; i++) {
      dao.deleteHistoryItem(historyItems[i]);
    }

    _historyData = LinkedHashMap<String, List<HistoryItem>>();
  }

  void _addTestData() {
    final List<String> words = [
      'images',
      'css',
      'LC_MESSAGES',
      'js',
      'tmpl',
      'lang',
      'default',
      'README',
      'templates',
      'langs',
      'config',
      'GNUmakefile',
      'themes',
      'en',
      'img',
      'admin',
      'user',
      'plugins',
      'show',
      'level',
      'exec',
      'po',
      'icons',
      'classes',
      'includes',
      '_notes',
      'system',
      'language',
      'MANIFEST',
      'modules',
      'error_log',
      'views',
      'backup',
      'db',
      'lib',
      'faqweb',
      'articleweb',
      'system32',
      'skins',
      '_vti_cnf',
      'models',
      'news',
      'cache',
      'CVS',
      'main',
      'html',
      'faq',
      'update',
      'extensions',
      'jscripts',
    ];
    final Random rng = new Random();

    final dao = Provider.of<HistoryItemDao>(context, listen: false);

    for (int i = 0; i < words.length; i++) {
      dao.insertHistoryItem(
        HistoryItemsCompanion.insert(
          item: words[i],
          checked: true,
          checkedTime: DateTime.now()
              .add(Duration(days: rng.nextInt(100), hours: rng.nextInt(24))),
          priority: rng.nextInt(3),
        ),
      );
    }
  }
}
