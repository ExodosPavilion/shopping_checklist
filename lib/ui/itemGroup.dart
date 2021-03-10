import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_checklist/data/AppDatabase.dart';

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

  void _newPresetScreenGenerator(
      {PresetsCompanion editItem, bool editing = false}) {
    //TODO: Create a preset screen generator. maybe in a different file?
  }

  StreamBuilder<List<ItemSet>> _buildList(BuildContext context) {
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
      builder: (context, AsyncSnapshot<List<ItemSet>> snapshot) {
        final groups = snapshot.data ?? [];

        return ListView.builder(
          itemCount: groups.length,
          itemBuilder: (BuildContext context, int index) {
            final group = groups[index];
            return _buildRow(group, PresetDao);
          },
        );
      },
    );
  }

  Widget _buildRow(preset, presetDao) {
    return Dismissible(
      key: UniqueKey(),
      background: _editSlide(),
      secondaryBackground: _deleteSlide(),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          presetDao.deleteItem(preset);
        } else {
          _newPresetScreenGenerator(
              editItem: preset.toCompanion(false), editing: true);
        }
      },
      child: ListTile(
        title: Text(preset.item),
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
