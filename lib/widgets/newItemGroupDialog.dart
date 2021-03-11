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
                ..._getFriends(),
                SizedBox(
                  height: 40,
                ),
                TextButton(
                  child: Text('Submit'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      presetDao.insertPreset(
                          PresetsCompanion.insert(name: _formController.text));
                      for (int i = 0; i < itemList.length; i++) {
                        setItemDao.insertSetItem(SetItemsCompanion.insert(
                            item: itemList[i],
                            priority: 0,
                            presetName: _formController.text));
                      }
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// get firends text-fields
  List<Widget> _getFriends() {
    List<Widget> friendsTextFields = [];
    for (int i = 0; i < itemList.length; i++) {
      friendsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(child: ItemTextField(i)),
            SizedBox(
              width: 16,
            ),
            // we need add button at last friends row
            _addRemoveButton(i == itemList.length - 1, i),
          ],
        ),
      ));
    }
    return friendsTextFields;
  }

  /// add / remove button
  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new text-fields at the top of all friends textfields
          itemList.insert(0, null);
        } else
          itemList.removeAt(index);
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
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
