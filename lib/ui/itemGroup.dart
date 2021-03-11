import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_checklist/data/AppDatabase.dart';
import 'package:shopping_checklist/widgets/newItemGroupDialog.dart';

class ItemGroup extends StatefulWidget {
  @override
  _ItemGroupState createState() => _ItemGroupState();
}

class _ItemGroupState extends State<ItemGroup> {
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
            print(group);
            print('test');
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
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          presetDao.deletePreset(preset);
        } else {
          _newPresetScreenGenerator();
        }
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
                  return ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(
                            300))), //TODO: Find out why this doesn't work
                    title: Text(_list[index].item),
                    tileColor: _list[index].priority == 0
                        ? Colors.yellow[300]
                        : _list[index].priority == 1
                            ? Colors.amber
                            : Colors.red,
                  );
                },
              ),
            ),
          );
        });
  }

  Widget _dialogTileGenerator(BuildContext context, List<SetItem> setItems) {}

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
