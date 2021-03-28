import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_checklist/data/AppDatabase.dart';
import 'package:moor/moor.dart';
import 'package:provider/provider.dart';
import 'package:shopping_checklist/widgets/AppDrawer.dart';

class CheckList extends StatefulWidget {
  @override
  _CheckListState createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {
  //the next position available
  int availablePosition;

  //the way the list gets sorted.
  // 0 = by name asc,
  // 1 = by name desc,
  // 2 = by priority desc,
  // 3 = by priority asc,
  // 4 = custom
  int sortOrder;

  //is the current app theme the dark one
  bool isDarkTheme = true;

  //what color the different priorities should be
  // index 0 = highPriority
  // index 1 = mediumPriority
  // index 2 = lowPriority
  List<Color> priorityColors;

  //are all the preferences loaded
  bool isLoaded = false;

  //what the time interval is between the user checking the item
  //and the app moving it to the history screen
  int _intervalAmount = 0;

  final myController = TextEditingController(); //used by the text field later
  FocusNode myFocusNode; //also used by the text field later

  void _updateAvailablePositions() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('availablePosition', availablePosition);
  }

  void _setSortOrder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('sortOrder', sortOrder);
  }

  void _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    isDarkTheme = (prefs.getBool('darkTheme') ?? true);

    if (isDarkTheme) {
      priorityColors = [
        Color(prefs.getInt('DarkHighPriority') ?? Colors.red.value),
        Color(prefs.getInt('DarkMediumPriority') ?? Colors.orange.value),
        Color(prefs.getInt('DarkLowPriority') ?? Colors.yellow.value),
      ];
    } else {
      priorityColors = [
        Color(prefs.getInt('lightHighPriority') ?? Colors.red[400].value),
        Color(prefs.getInt('lightMediumPriority') ?? Colors.orange[400].value),
        Color(prefs.getInt('lightLowPriority') ?? Colors.yellow[400].value),
      ];
    }

    sortOrder = (prefs.getInt('sortOrder') ?? 0);

    availablePosition = (prefs.getInt('availablePosition') ?? 0);

    _intervalAmount = prefs.getInt('timeIntervalCheckToHistory') ?? 0;

    availablePosition = (prefs.getInt('availablePosition') ?? 0);

    isLoaded = true;

    setState(() {});
  }

  void _cleanUp() {
    if (isLoaded) {
      final itemDao = Provider.of<ItemDao>(context, listen: false);
      final historyDao = Provider.of<HistoryItemDao>(context, listen: false);

      itemDao.getCheckedItemsOlderThanXHours(_intervalAmount).then(
        (val) {
          for (Item item in val) {
            historyDao.insertHistoryItem(
              HistoryItemsCompanion.insert(
                item: item.item,
                priority: item.priority,
                checked: item.checked,
                position: Value(item.position),
                checkedTime: item.checkedTime,
              ),
            );
            itemDao.deleteItem(item);
          }
        },
      );
    }
  }

  @override
  void initState() {
    _loadData();

    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node and controller when the Form is disposed.
    myController.dispose();
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _cleanUp();

    return !isLoaded
        ? CircularProgressIndicator()
        : Scaffold(
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
                PopupMenuButton(
                  onSelected: (int result) {
                    setState(
                      () {
                        print(result);
                        sortOrder = result;
                        _setSortOrder();
                      },
                    );
                  },
                  icon: Icon(Icons.sort),
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                    PopupMenuItem(
                      value: 0,
                      child: Text("Sort by Name (A -> Z)"),
                    ),
                    PopupMenuItem(
                      value: 1,
                      child: Text("Sort by Name (Z -> A)"),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Text("Sort by Priority (high -> low)"),
                    ),
                    PopupMenuItem(
                      value: 3,
                      child: Text("Sort by Priority (low -> high)"),
                    ),
                    PopupMenuItem(
                      value: 4,
                      child: Text("Custom order"),
                    ),
                  ],
                ),
              ],
            ),
            drawer: AppDrawer("CheckList"),
            floatingActionButton: FloatingActionButton(
              onPressed:
                  _newItemScreenGenerator, //Function that runs when the button is pressed
              child: Icon(Icons.add),
            ), //Creates the floating action button
            body: _buildList(context),
          );
  }

  void _newItemScreenGenerator(
      {ItemsCompanion editItem, bool editing = false}) {
    myFocusNode = FocusNode();
    myFocusNode.requestFocus();
    var tempPriority = 0;
    final dao = Provider.of<ItemDao>(context, listen: false);

    if (editItem != null) {
      tempPriority = editItem.priority.value;
      myController.text = editItem.item.value;
    }

    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return SimpleDialog(
              title: const Text('Enter item info:'),
              children: <Widget>[
                SimpleDialogOption(
                  onPressed: () {},
                  child: TextField(
                    controller: myController,
                    focusNode: myFocusNode,
                  ),
                ),
                SimpleDialogOption(
                  child: DropdownButton(
                    value: tempPriority,
                    items: <DropdownMenuItem>[
                      DropdownMenuItem(child: Text("High"), value: 2),
                      DropdownMenuItem(child: Text("Medium"), value: 1),
                      DropdownMenuItem(child: Text("Low"), value: 0),
                    ],
                    onChanged: (priority) {
                      setState(() {
                        tempPriority = priority;
                      });
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SimpleDialogOption(
                    onPressed: () {},
                    child: TextButton(
                      onPressed: () {
                        if (!editing) {
                          ItemsCompanion item = ItemsCompanion.insert(
                            item: myController.text,
                            priority: tempPriority,
                            position: availablePosition,
                          );
                          dao.insertItem(item);
                          availablePosition += 1;
                          _updateAvailablePositions();
                        } else {
                          dao.updateItem(editItem.copyWith(
                              item: Value(myController.text),
                              priority: Value(tempPriority)));
                        }
                        myController.clear();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Add',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            );
          });
        });
  }

  StreamBuilder<List<Item>> _buildList(BuildContext context) {
    //builds a list of items using the rows provided by _buildRow
/*     return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _list.length,
        itemBuilder: (BuildContext _context, int i) {
          return _buildRow(_list[i]);
        }); */
    final dao = Provider.of<ItemDao>(context);
    Stream<List<Item>> streamForItems;

    switch (sortOrder) {
      case 0:
        streamForItems = dao.watchItemsSortedByNameAsc();
        break;
      case 1:
        streamForItems = dao.watchItemsSortedByNameDesc();
        break;
      case 2:
        streamForItems = dao.watchItemsSortedByPriorityDesc();
        break;
      case 3:
        streamForItems = dao.watchItemsSortedByPriorityAsc();
        break;
      case 4:
        streamForItems = dao.watchItemsSortedByPosition();
        break;
      default:
        streamForItems = dao.watchAllItems();
    }

    return StreamBuilder(
      stream: streamForItems,
      builder: (context, AsyncSnapshot<List<Item>> snapshot) {
        final items = snapshot.data ?? [];
        availablePosition = items.length;
        _updateAvailablePositions();

        return ReorderableListView(
            children: _getListItems(items, dao),
            onReorder: (oldIndex, newIndex) {
              // Code ReorderableListView problem code from: https://gist.github.com/ffeu/e6ab522bdbcdfdfc7056bcc7ff2f67c7
              // These two lines are workarounds for ReorderableListView problems
              if (newIndex > items.length) newIndex = items.length;
              if (oldIndex < newIndex) newIndex--;

              items.insert(newIndex, items.removeAt(oldIndex));

              for (int i = 0; i < items.length; i++) {
                dao.updateItem(items[i].copyWith(position: i));
              }
            });
      },
    );
  }

  List<Widget> _getListItems(List items, ItemDao itemdao) => items
      .asMap()
      .map((i, item) => MapEntry(i, _buildRow(item, itemdao)))
      .values
      .toList();

  Widget _buildRow(Item item, ItemDao itemDao) {
    //Builds a row for a list
    bool checked = item.checked;
    final historyDao = Provider.of<HistoryItemDao>(context, listen: false);

    return Dismissible(
      key: UniqueKey(),
      background: _editSlide(),
      secondaryBackground: _deleteSlide(),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          itemDao.deleteItem(item);
        } else {
          _newItemScreenGenerator(
              editItem: item.toCompanion(false), editing: true);
        }
      },
      child: ListTile(
        title: Text(
          item.item,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          item.checkedTime.toString(),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: Icon(
          checked
              ? Icons.check_box
              : Icons
                  .check_box_outline_blank, //if checked then use check_box else use check_box_outline_blank
          color: Colors.black,
        ),
        tileColor: item.priority == 0
            ? priorityColors[2]
            : item.priority == 1
                ? priorityColors[1]
                : priorityColors[0],
        onTap: () {
          //when tapped set the state of the item to either checked or not depending on the previous value
          setState(
            () {
              checked = !checked;
              itemDao.updateItem(
                item.copyWith(checked: checked, checkedTime: DateTime.now()),
              );
              if (_intervalAmount == 0) {
                historyDao.insertHistoryItem(
                  HistoryItemsCompanion.insert(
                    item: item.item,
                    priority: item.priority,
                    checked: true,
                    position: Value(item.position),
                    checkedTime: DateTime.now(),
                  ),
                );
                itemDao.deleteItem(item);
              }
            },
          );
        },
      ),
    );
  }

  Container _editSlide() {
    return Container(
        color: Colors.green,
        child: Align(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ],
          ),
          alignment: Alignment.centerLeft,
        ));
  }

  Container _deleteSlide() {
    return Container(
        color: Colors.red,
        child: Align(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.delete,
                color: Colors.white,
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          alignment: Alignment.centerRight,
        ));
  }

  void _deleteAll() async {
    final dao = Provider.of<ItemDao>(context, listen: false);
    final List<Item> items = await dao.getAllItems();

    for (int i = 0; i < items.length; i++) {
      dao.deleteItem(items[i]);
    }
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

    final dao = Provider.of<ItemDao>(context, listen: false);

    for (int i = 0; i < words.length; i++) {
      dao.insertItem(
        ItemsCompanion.insert(
          item: words[i],
          position: i,
          checked: Value(rng.nextBool()),
          checkedTime: Value(DateTime.now().subtract(
              Duration(days: rng.nextInt(1), hours: rng.nextInt(24)))),
          priority: rng.nextInt(3),
        ),
      );
    }
  }
}
