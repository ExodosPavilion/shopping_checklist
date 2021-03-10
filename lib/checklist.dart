import 'package:flutter/material.dart';
import 'package:shopping_checklist/data/ChecklistDatabase.dart';

class CheckList extends StatefulWidget {
  @override
  _CheckListState createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {
  //Stores all the checklist items entered by the user
  List<Item> _list = <Item>[];

  //the next position available
  int availablePosition = 0;

  final myController = TextEditingController(); //used by the text field later
  FocusNode myFocusNode; //also used by the text field later

  @override
  void initState() {
    super.initState();
    ChecklistDatabase().itemDao.getAllItems().then((val) => setState(() {
          _list = val;
        }));

    if (_list.length != 0) {
      availablePosition = _list[_list.length - 1].position;
    }

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping CheckList'),
        //actions: [IconButton(icon: Icon(Icons.menu), onPressed: _navbar),], //used to get a navbar on the right (not what we need, lookup: drawer)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            _newItemScreenGenerator, //Function that runs when the button is pressed
        child: Icon(Icons.add),
      ), //Creates the floating action button
      body: _buildList(),
    );
  }

  void _newItemScreenGenerator({Item focusItem, int itemIndex = -1}) {
    myFocusNode = FocusNode();
    myFocusNode.requestFocus();
    var tempPriority = 0;

    if (focusItem != null) {
      tempPriority = focusItem.priority;
      myController.text = focusItem.item;
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
                        onPressed: () async {
                          super.setState(() {
                            if (itemIndex == -1) {
                              focusItem = Item(
                                  item: myController.text,
                                  priority: tempPriority,
                                  checked: false,
                                  position: availablePosition);
                              _list.add(focusItem);
                              availablePosition += 1;
                            } else {
                              focusItem.item = myController.text;
                              focusItem.priority = tempPriority;
                              _list.insert(itemIndex, focusItem);
                              ChecklistDatabase().itemDao.updateItem(focusItem);
                            }
                            myController.clear();
                          });
                          if (itemIndex == -1) {
                            var temp = await ChecklistDatabase()
                                .itemDao
                                .insertItem(focusItem);
                            print(temp);
                          }
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Add',
                          style: TextStyle(fontSize: 18),
                        )),
                  ),
                ),
              ],
            );
          });
        });
  }

  Widget _buildList() {
    //builds a list of items using the rows provided by _buildRow
/*     return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _list.length,
        itemBuilder: (BuildContext _context, int i) {
          return _buildRow(_list[i]);
        }); */
    return ReorderableListView(
      children: _getListItems(),
      onReorder: (oldIndex, newIndex) {
        _updateList(oldIndex, newIndex);
      },
    );
  }

  List<Widget> _getListItems() => _list
      .asMap()
      .map((i, item) => MapEntry(i, _buildRow(item)))
      .values
      .toList();

  void _updateList(int oldIndex, int newIndex) {
    setState(() {
      // Code ReorderableListView problem code from: https://gist.github.com/ffeu/e6ab522bdbcdfdfc7056bcc7ff2f67c7
      // These two lines are workarounds for ReorderableListView problems
      if (newIndex > _list.length) newIndex = _list.length;
      if (oldIndex < newIndex) newIndex--;

      _list.insert(newIndex, _list.removeAt(oldIndex));

      _updatePositions();
    });
  }

  void _updatePositions() async {
    for (int i = 0; i < _list.length; i++) {
      _list[i].position = i;
      await ChecklistDatabase().itemDao.updateItem(_list[i]);
    }
  }

  Widget _buildRow(Item item) {
    //Builds a row for a list
    final checked = item.checked;

    return Dismissible(
      key: UniqueKey(),
      background: _editSlide(),
      secondaryBackground: _deleteSlide(),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          _list.remove(item);
          ChecklistDatabase().itemDao.deleteItem(item);
        } else {
          var itemPosition = _list.indexOf(item);
          var itemCopy = _list.removeAt(itemPosition);
          _newItemScreenGenerator(focusItem: itemCopy, itemIndex: itemPosition);
        }
      },
      child: ListTile(
        title: Text(item.item),
        leading: Icon(
          checked
              ? Icons.check_box
              : Icons
                  .check_box_outline_blank, //if checked then use check_box else use check_box_outline_blank
        ),
        tileColor: item.priority == 0
            ? Colors.yellow[300]
            : item.priority == 1
                ? Colors.amber
                : Colors.red,
        onTap: () {
          //when tapped set the state of the item to either checked or not depending on the previous value
          setState(() {
            if (checked) {
              item.checked = false;
            } else {
              item.checked = true;
            }
            ChecklistDatabase().itemDao.updateItem(item);
          });
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
}
