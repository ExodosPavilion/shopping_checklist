import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_checklist/constants.dart';
import 'package:shopping_checklist/data/AppDatabase.dart';
import 'package:shopping_checklist/widgets/AppDrawer.dart';

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

  //are the preferences loaded
  bool isLoaded = false;

  //key used by the form fields
  final _formKey = GlobalKey<FormState>();

  //Text field controller for the preset name
  TextEditingController _formController;

  //Used to temporarily store the items being entered into a preset
  List<String> itemList = [null];

  //Used to temporarily store the priority of the items being entered into a preset
  List<int> priorityList = [0];

  void _updateAvailablePositions() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(kAvailablePosition, availablePositionsInCheckList);
  }

  void _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    isDarkTheme = (prefs.getBool(kIsDarkTheme) ?? true);

    if (isDarkTheme) {
      priorityColors = [
        Color(
            prefs.getInt(kDarkHighPriority) ?? kDefaultDarkHighPriority.value),
        Color(prefs.getInt(kDarkMediumPriority) ??
            kDefaultDarkMediumPriority.value),
        Color(prefs.getInt(kDarkLowPriority) ?? kDefaultDarkLowPriority.value),
      ];
    } else {
      priorityColors = [
        Color(prefs.getInt(kLightHighPriority) ??
            kDefaultlightHighPriority.value),
        Color(prefs.getInt(kLightMediumPriority) ??
            kDefaultlightMediumPriority.value),
        Color(
            prefs.getInt(kLightLowPriority) ?? kDefaultlightLowPriority.value),
      ];
    }

    availablePositionsInCheckList =
        (prefs.getInt(kAvailablePosition) ?? kDefAvailablePositions);

    isLoaded = true;

    setState(() {});
  }

  @override
  void initState() {
    _loadData();

    _formController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !isLoaded
        ? CircularProgressIndicator()
        : Scaffold(
            appBar: AppBar(
              title: Text(kPresetScreen),
              /* actions: [
                IconButton(
                  icon: Icon(Icons.add_circle_outline),
                  onPressed: _addTestData,
                ),
                IconButton(
                  icon: Icon(Icons.remove_circle_outline),
                  onPressed: _deleteAll,
                ),
              ], */
            ),
            drawer: AppDrawer(kPresetAppDrawer),
            floatingActionButton: FloatingActionButton(
              onPressed:
                  _newPresetScreenGenerator, //Function that runs when the button is pressed
              child: Icon(Icons.add),
            ), //Creates the floating action button
            body: _buildList(context),
          );
  }

  void _newPresetScreenGenerator() {
    final setItemDao = Provider.of<SetItemDao>(context, listen: false);
    final presetDao = Provider.of<PresetDao>(context, listen: false);
    bool disableRemoveButton = itemList.length == 1;

    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text(kNewPresetDialogTitle),
            children: [
              StatefulBuilder(builder: (context, setState) {
                return Form(
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
                            decoration: InputDecoration(
                                hintText: kNewPresetDialogNameHint),
                            validator: (v) {
                              if (v.trim().isEmpty)
                                return kNewPresetDialogInvalidNameError;
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          kNewPresetDialogAddItemsTitle,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                        ..._getTextFields(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                                onPressed: () => {
                                      setState(() {
                                        itemList.add(null);
                                        priorityList.add(0);
                                        if (disableRemoveButton) {
                                          disableRemoveButton =
                                              !disableRemoveButton;
                                        }
                                      })
                                    },
                                child: Text(kNewPresetDialogNewRowButtonText),
                                style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    backgroundColor: Colors.green)),
                            TextButton(
                                onPressed: () => {
                                      setState(() {
                                        if (itemList.length == 1) {
                                          disableRemoveButton = true;
                                        } else {
                                          itemList
                                              .removeAt(itemList.length - 1);
                                          priorityList.removeAt(
                                              priorityList.length - 1);

                                          if (itemList.length == 1) {
                                            disableRemoveButton = true;
                                          } else {
                                            disableRemoveButton = false;
                                          }
                                        }
                                      }),
                                    },
                                child: Text(kNewPresetDialogDelRowButtonText),
                                style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    backgroundColor: disableRemoveButton
                                        ? Colors.grey
                                        : Colors.red))
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            child: Text(kNewPresetDialogSubmitButtonText),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                presetDao.insertPreset(PresetsCompanion.insert(
                                    name: _formController.text));
                                for (int i = 0; i < itemList.length; i++) {
                                  setItemDao
                                      .insertSetItem(SetItemsCompanion.insert(
                                    item: itemList[i],
                                    priority: priorityList[i],
                                    presetId: (await (presetDao.getPresetId(
                                            _formController.text)))[0]
                                        .id,
                                  ));
                                }
                                itemList = [null];
                                priorityList = [0];
                                Navigator.of(context).pop();
                              }
                            },
                            style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          );
          //});
        });
  }

  /// get text-fields
  List<Widget> _getTextFields() {
    List<Widget> textFields = [];
    for (int i = 0; i < itemList.length; i++) {
      textFields.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 2,
                child: ItemTextField(itemList, priorityList, i),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                flex: 1,
                child: _addPriorityDropDown(i),
              ),
            ],
          ),
        ),
      );
    }
    return textFields;
  }

  Widget _addPriorityDropDown(int index) {
    var tempPriority = priorityList[index];

    return DropdownButtonFormField(
      value: tempPriority,
      items: <DropdownMenuItem>[
        DropdownMenuItem(child: Text(kDropDownMenuHigh), value: 2),
        DropdownMenuItem(child: Text(kDropDownMenuMedium), value: 1),
        DropdownMenuItem(child: Text(kDropDownMenuLow), value: 0),
      ],
      onChanged: (priority) {
        priorityList[index] = priority;
        setState(() {
          tempPriority = priority;
        });
      },
    );
  }

  StreamBuilder<List<Preset>> _buildList(BuildContext context) {
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
      background: _editSlide(),
      secondaryBackground: _deleteSlide(),
      onDismissed: (direction) async {
        final setItemDao = Provider.of<SetItemDao>(context, listen: false);

        if (direction == DismissDirection.endToStart) {
          setItemDao.getItemsforPreset(preset).then(
            (value) {
              for (int i = 0; i < value.length; i++) {
                setItemDao.deleteSetItem(value[i]);
              }
              presetDao.deletePreset(preset);
            },
          );
        } else {
          setItemDao.getItemsforPreset(preset).then(
            (value) {
              itemList = [];
              priorityList = [];
              _formController.text = preset.name;

              for (int i = 0; i < value.length; i++) {
                itemList.add(value[i].item);
                priorityList.add(value[i].priority);
              }

              _newPresetScreenGenerator();
            },
          );
        }
      },
      child: ListTile(
        title: Text(
          preset.name,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        onTap: () => _showPresetsDialog(preset, presetDao),
      ),
    );
  }

  void _showPresetsDialog(Preset preset, PresetDao dao) async {
    final setItemDao = Provider.of<SetItemDao>(context, listen: false);
    List<SetItem> _list = await setItemDao.getItemsforPreset(preset);
    List<Widget> rows = _getListItems(_list);
    rows.add(
      Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Text(kShowPresetAddToCheckListButtonText),
              onPressed: () {
                var checklistDao = Provider.of<ItemDao>(context, listen: false);
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
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                primary: isDarkTheme ? Colors.black : Colors.white,
                backgroundColor: isDarkTheme ? Colors.grey[400] : Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );

    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text(preset.name),
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .8,
                height: MediaQuery.of(context).size.height * .7,
                child: ListView(children: rows),
              ),
            ],
          );
        });
  }

  List<Widget> _getListItems(List items) => items
      .asMap()
      .map(
        (i, item) => MapEntry(
          i,
          Card(
            color: item.priority == 0
                ? priorityColors[2]
                : item.priority == 1
                    ? priorityColors[1]
                    : priorityColors[0],
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  Text(
                    item.item,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
      .values
      .toList();

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
            //mainAxisAlignment: MainAxisAlignment.end,
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

  /* void _deleteAll() async {
    final presetDao = Provider.of<PresetDao>(context, listen: false);
    final setItemDao = Provider.of<SetItemDao>(context, listen: false);

    final List<Preset> items = await presetDao.getAllItems();

    for (Preset preset in items) {
      setItemDao.getItemsforPreset(preset).then(
        (value) {
          for (int i = 0; i < value.length; i++) {
            setItemDao.deleteSetItem(value[i]);
          }
          presetDao.deletePreset(preset);
        },
      );
    }
  }

  void _addTestData() async {
    final Map<String, List<String>> words = {
      'first': [
        'images',
        'css',
        'LC_MESSAGES',
        'js',
        'tmpl',
      ],
      'second': [
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
      ],
      'third': [
        'plugins',
        'show',
        'level',
        'exec',
        'po',
        'icons',
        'classes',
      ],
      'fourth': [
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
      ],
      'fifth': [
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
      ],
    };
    final Random rng = new Random();

    final presetDao = Provider.of<PresetDao>(context, listen: false);
    final setItemDao = Provider.of<SetItemDao>(context, listen: false);

    words.forEach(
      (key, value) async {
        presetDao.insertPreset(PresetsCompanion.insert(name: key));
        for (String itemName in value) {
          setItemDao.insertSetItem(
            SetItemsCompanion.insert(
              item: itemName,
              priority: rng.nextInt(3),
              presetId: (await presetDao.getPresetId(key))[0].id,
            ),
          );
        }
      },
    );
  } */
}

class ItemTextField extends StatefulWidget {
  final int index;
  final List<String> itemList;
  final List<int> priorityList;

  ItemTextField(this.itemList, this.priorityList, this.index);

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
      _textFeildController.text = widget.itemList[widget.index] ?? '';
    });

    return TextFormField(
      controller: _textFeildController,
      onChanged: (v) => widget.itemList[widget.index] = v,
      decoration: InputDecoration(hintText: 'Enter your item\'s information'),
      validator: (v) {
        if (v.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}
