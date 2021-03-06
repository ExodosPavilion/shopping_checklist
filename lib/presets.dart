import 'package:flutter/material.dart';
import './Item.dart';
import './ItemSet.dart';
import 'PresetsDatabaseHelper.dart';

class Presets extends StatefulWidget {
  @override
  _PresetsState createState() => _PresetsState();
}

class _PresetsState extends State<Presets> {
  //Stores all the item set stored in the database
  List<ItemSet> _list = <ItemSet>[];

  //Is a list that will be used to hold the itemset data temporarily
  static List<Item> setItems = [null];

  //Used by the form widgets
  final _formKey = GlobalKey<FormState>();

  //the next position available
  int availablePosition = 0;

  final myController = TextEditingController(); //used by the text field later
  FocusNode myFocusNode; //also used by the text field later

  @override
  void initState() {
    super.initState();
    PresetsDatabaseHelper.itemSets().then((val) => setState(() {
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
            _newPresetScreenGenerator, //Function that runs when the button is pressed
        child: Icon(Icons.add),
      ), //Creates the floating action button
      body: _buildList(),
    );
  }

  void _newPresetScreenGenerator() {
    myFocusNode = FocusNode();
    myFocusNode.requestFocus();
    var tempPriority = 0;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Enter the preset information'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {},
                child: TextField(
                  controller: myController,
                  focusNode: myFocusNode,
                ),
              ),
              SimpleDialogOption(
                  child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 32.0),
                        child: TextFormField(
                          controller: myController,
                          decoration: InputDecoration(hintText: 'Item name'),
                          validator: (v) {
                            if (v.trim().isEmpty) {
                              return 'Please enter something';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Add Items',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      ..._getItems(),
                      SizedBox(
                        height: 40,
                      ),
                      TextButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                          }
                        },
                        child: Text('Submit'),
                      )
                    ],
                  ),
                ),
              ))
            ],
          );
        });
  }

  List<Widget> _getItems() {
    List<Widget> itemTextFields = [];

    for (int i = 0; i < setItems.length; i++) {
      itemTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ItemTextFields(i),
      ));
    }

    return itemTextFields;
  }

  Widget _buildList() {
    return null;
  }
}

class ItemTextFields extends StatefulWidget {
  final int index;
  ItemTextFields(this.index);

  @override
  _ItemTextFieldsState createState() => _ItemTextFieldsState();
}

class _ItemTextFieldsState extends State<ItemTextFields> {
  TextEditingController _itemController;

  @override
  void initState() {
    super.initState();
    _itemController = TextEditingController();
  }

  @override
  void dispose() {
    _itemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var tempPriority = 0;
    var tempItem = Item(
      item: '',
      priority: tempPriority,
      checked: false,
      position: _PresetsState.setItems.length,
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _itemController.text = _PresetsState.setItems[widget.index] ?? '';
    });

    return Row(
      children: [
        Expanded(
            child: TextFormField(
          controller: _itemController,
          onChanged: (v) {
            tempItem.item = v;
            _PresetsState.setItems[widget.index] = tempItem;
          },
          decoration: InputDecoration(hintText: 'Item Name'),
          validator: (v) {
            if (v.trim().isEmpty) {
              return 'Please enter an Item Name';
            }
            return null;
          },
        )),
        DropdownButton(
          value: tempPriority,
          items: <DropdownMenuItem>[
            DropdownMenuItem(child: Text("High"), value: 2),
            DropdownMenuItem(child: Text("Medium"), value: 1),
            DropdownMenuItem(child: Text("Low"), value: 0),
          ],
          onChanged: (priority) {
            tempPriority = priority;
            tempItem.priority = priority;
            _PresetsState.setItems[widget.index] = tempItem;
          },
        ),
      ],
    );
  }
}
