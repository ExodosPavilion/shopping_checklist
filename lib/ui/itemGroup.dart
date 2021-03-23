import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_checklist/data/AppDatabase.dart';
import 'package:shopping_checklist/widgets/AppDrawer.dart';
import 'package:shopping_checklist/widgets/newItemGroupDialog.dart';

class ItemGroup extends StatefulWidget {
  @override
  _ItemGroupState createState() => _ItemGroupState();
}

class _ItemGroupState extends State<ItemGroup> {
  //the last posistion available in the checklist page list
  int availablePositionsInCheckList;

  //is the current app theme the dark one
  bool isDarkTheme = true;

  //what color the different priorities should be
  // index 0 = highPriority
  // index 1 = mediumPriority
  // index 2 = lowPriority
  List<Color> priorityColors;

  void _loadAvailablePositions() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    availablePositionsInCheckList = (prefs.getInt('availablePosition') ?? 0);
  }

  void _updateAvailablePositions() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('availablePosition', availablePositionsInCheckList);
  }

  void _loadThemeData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkTheme = (prefs.getBool('darkTheme') ?? true);
  }

  void _loadLightPriorityColors() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int highPriority = (prefs.getInt('highPriority') ?? Colors.red[400].value);
    int mediumPriority =
        (prefs.getInt('mediumPriority') ?? Colors.orange[400].value);
    int lowPriority = (prefs.getInt('lowPriority') ?? Colors.yellow[400].value);

    priorityColors = [
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

    priorityColors = [
      Color(highPriority),
      Color(mediumPriority),
      Color(lowPriority),
    ];
  }

  void _loadData() {
    _loadAvailablePositions();
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping CheckList'),
        //actions: [IconButton(icon: Icon(Icons.menu), onPressed: _navbar),], //used to get a navbar on the right (not what we need, lookup: drawer)
      ),
      drawer: AppDrawer("ItemGroup"),
      floatingActionButton: FloatingActionButton(
        onPressed:
            _newPresetScreenGenerator, //Function that runs when the button is pressed
        child: Icon(Icons.add),
      ), //Creates the floating action button
      body: _buildList(context),
    );
  }

  void _newPresetScreenGenerator() {
    showDialog(
        context: context,
        builder: (context) {
          //return StatefulBuilder(builder: (context, setState) {
          return NewItemGroupDialog();
          //});
        });
  }

  StreamBuilder<List<Preset>> _buildList(BuildContext context) {
    //builds a list of items using the rows provided by _buildRow
/*     return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _list.length,
        itemBuilder: (BuildContext _context, int i) {
          return _buildRow(_list[i]);
        }); */
    final dao = Provider.of<PresetDao>(context);
    return StreamBuilder(
      stream: dao.watchAllItems(),
      builder: (context, AsyncSnapshot<List<Preset>> snapshot) {
        final groups = snapshot.data ?? [];

        return ListView.builder(
          itemCount: groups.length,
          itemBuilder: (BuildContext context, int index) {
            final group = groups[index];
            return _buildRow(group, dao);
          },
        );
      },
    );
  }

  Widget _buildRow(Preset preset, PresetDao presetDao) {
    return Dismissible(
      key: UniqueKey(),
      //background: _editSlide(),
      //secondaryBackground: _deleteSlide(),
      background: _deleteSlide(),
      onDismissed: (direction) async {
        final setItemDao = Provider.of<SetItemDao>(context, listen: false);
        List<SetItem> _list = await setItemDao.getItemsforPreset(preset);

        for (int i = 0; i < _list.length; i++) {
          setItemDao.deleteSetItem(_list[i]);
        }
        presetDao.deletePreset(preset);
      },
      child: ListTile(
        title: Text(preset.name),
        onTap: () => _showPresetsDialog(preset, presetDao),
      ),
    );
  }

  void _showPresetsDialog(Preset preset, PresetDao dao) async {
    final setItemDao = Provider.of<SetItemDao>(context, listen: false);
    List<SetItem> _list = await setItemDao.getItemsforPreset(preset);

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(preset.name),
            content: Container(
              height: 300.0,
              width: 300.0,
              child: ListView.builder(
                itemCount: _list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: ListTile(
                        title: Text(
                          _list[index].item,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        tileColor: _list[index].priority == 0
                            ? priorityColors[2]
                            : _list[index].priority == 1
                                ? priorityColors[1]
                                : priorityColors[0],
                      ),
                    ),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                child: Text("Add to Check List"),
                onPressed: () {
                  var checklistDao =
                      Provider.of<ItemDao>(context, listen: false);
                  for (int i = 0; i < _list.length; i++) {
                    checklistDao.insertItem(
                      ItemsCompanion.insert(
                          item: _list[i].item,
                          priority: _list[i].priority,
                          position: availablePositionsInCheckList),
                    );
                    availablePositionsInCheckList += 1;
                    _updateAvailablePositions();
                  }
                },
                style: TextButton.styleFrom(
                  primary: isDarkTheme ? Colors.black : Colors.white,
                  backgroundColor: isDarkTheme ? Colors.grey[400] : Colors.blue,
                ),
              ),
            ],
          );
        });
  }

/*   Container _editSlide() {
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
  } */

  Container _deleteSlide() {
    return Container(
        color: Colors.red,
        child: Align(
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
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
}
