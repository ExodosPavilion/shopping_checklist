import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_checklist/data/AppDatabase.dart';

class NewItemGroupDialog extends StatefulWidget {
  @override
  _NewItemGroupDialogState createState() => _NewItemGroupDialogState();
}

class _NewItemGroupDialogState extends State<NewItemGroupDialog> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _formController;
  static List<String> itemList = [null];
  static List<int> priorityList = [0];

  @override
  void initState() {
    super.initState();
    _formController = TextEditingController();
  }

  @override
  void dispose() {
    _formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final setItemDao = Provider.of<SetItemDao>(context, listen: false);
    final presetDao = Provider.of<PresetDao>(context, listen: false);
    bool disableRemoveButton = itemList.length < 1;

    return SimpleDialog(
      title: const Text('Enter preset info:'),
      children: [
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // name textfield
                Padding(
                  padding: const EdgeInsets.only(right: 32.0),
                  child: TextFormField(
                    controller: _formController,
                    decoration:
                        InputDecoration(hintText: 'Enter the preset name'),
                    validator: (v) {
                      if (v.trim().isEmpty) return 'Please enter something';
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Add Items',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                ..._getTextFields(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () => {
                              itemList.add(null),
                              priorityList.add(0),
                              setState(() {})
                            },
                        child: Text('Add New Item'),
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.green)),
                    TextButton(
                        onPressed: () => {
                              if (itemList.length >= 1)
                                {
                                  disableRemoveButton = false,
                                  itemList.removeAt(itemList.length - 1),
                                  priorityList
                                      .removeAt(priorityList.length - 1),
                                }
                              else
                                {
                                  disableRemoveButton = true,
                                  null,
                                },
                              setState(() {})
                            },
                        child: Text("Remove Last Item"),
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor:
                                disableRemoveButton ? Colors.grey : Colors.red))
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    child: Text('Submit'),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        presetDao.insertPreset(PresetsCompanion.insert(
                            name: _formController.text));
                        for (int i = 0; i < itemList.length; i++) {
                          setItemDao.insertSetItem(SetItemsCompanion.insert(
                            item: itemList[i],
                            priority: priorityList[i],
                            presetId: (await (presetDao
                                    .getPresetId(_formController.text)))[0]
                                .id,
                          ));
                        }
                        itemList = [null];
                        priorityList = [0];
                        Navigator.of(context).pop();
                      }
                    },
                    style: TextButton.styleFrom(
                        primary: Colors.white, backgroundColor: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// get text-fields
  List<Widget> _getTextFields() {
    List<Widget> textFields = [];
    for (int i = 0; i < itemList.length; i++) {
      textFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(flex: 2, child: ItemTextField(i)),
            SizedBox(
              width: 16,
            ),
            Expanded(flex: 1, child: _addPriorityDropDown(i)),
          ],
        ),
      ));
    }
    return textFields;
  }

  Widget _addPriorityDropDown(int index) {
    var tempPriority = priorityList[index];

    return DropdownButtonFormField(
      value: tempPriority,
      items: <DropdownMenuItem>[
        DropdownMenuItem(child: Text("High"), value: 2),
        DropdownMenuItem(child: Text("Medium"), value: 1),
        DropdownMenuItem(child: Text("Low"), value: 0),
      ],
      onChanged: (priority) {
        priorityList[index] = priority;
        setState(() {
          tempPriority = priority;
        });
      },
    );
  }
}

class ItemTextField extends StatefulWidget {
  final int index;

  ItemTextField(this.index);

  @override
  _ItemTextFieldState createState() => _ItemTextFieldState();
}

class _ItemTextFieldState extends State<ItemTextField> {
  TextEditingController _textFeildController;

  @override
  void initState() {
    super.initState();
    _textFeildController = TextEditingController();
  }

  @override
  void dispose() {
    _textFeildController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _textFeildController.text =
          _NewItemGroupDialogState.itemList[widget.index] ?? '';
    });

    return TextFormField(
      controller: _textFeildController,
      onChanged: (v) => _NewItemGroupDialogState.itemList[widget.index] = v,
      decoration: InputDecoration(hintText: 'Enter your item\'s information'),
      validator: (v) {
        if (v.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}
