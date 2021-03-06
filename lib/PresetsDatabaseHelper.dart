import 'package:shopping_checklist/ItemSet.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'Item.dart';

/* 
SetItems -> the items that are found in an Item Set
ItemSet -> A set of predefined items


insertSetItems -> insert set items into a database <- List<Items> required
insertItemSet -> insert an item set into a database <- ItemSet required

setItems -> returns the items assocciated with a given item set <- ItemSet required
itemSets -> returns the item sets in the database

updateSetItems - Updates one specific Item in the set items database <- Item required
batchUpdateSetItems - Updates a bunch of Items in the set items database <- List<Item> required
updateItemSet -> Updates an Item set <- ItemSet required

deleteSetItems -> Deletes a specific Item from the set items database <- int required
batchDeleteItemSet -> Deletes a bunch of Items in the set items database <- List<int> required
deleteItemSet  -> Deletes an item set from the database
*/

class PresetsDatabaseHelper {
  static Database _database;

  static Future<Database> getDBConnector() async {
    if (_database != null) {
      return _database;
    }

    return await _initDatabase();
  }

  //Open DB Connection, returns a Database instance.
  static Future<Database> _initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), "presets.db"),
      onCreate: (db, version) => _createDb(db),
      onConfigure: _onConfigure,
      version: 1,
    );

    return _database;
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  static void _createDb(Database db) async {
    await db.execute(
        'CREATE TABLE item_sets(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, itemIds TEXT, position INTEGER)');
    await db.execute(
        "CREATE TABLE set_items(id INTEGER PRIMARY KEY AUTOINCREMENT, item TEXT, priority INTEGER, checked INTEGER, position INTEGER, FOREIGN KEY (item_sets_id) REFERENCES item_sets (id) ON DELETE NO ACTION ON UPDATE NO ACTION)");
  }

  static Future<void> insertSetItems(List<Item> presetItems) async {
    final Database db = await getDBConnector();

    for (Item item in presetItems) {
      await db.insert('set_items', item.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  static Future<void> insertItemSet(ItemSet itemSet) async {
    final Database db = await getDBConnector();

    await db.insert('item_sets', itemSet.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Item>> setItems(ItemSet itemSet) async {
    final Database db = await getDBConnector();

    final List<Map<String, dynamic>> maps = await db.query('set_items',
        where: 'item_sets_id = ?',
        whereArgs: [itemSet.id],
        orderBy: 'position');

    return List.generate(maps.length, (i) {
      return Item(
          id: maps[i]['id'],
          item: maps[i]['item'],
          priority: maps[i]['priority'],
          checked: maps[i]['checked'] == 0 ? false : true,
          position: maps[i]['position'],
          presetId: maps[i]['item_sets_id']);
    });
  }

  static Future<List<ItemSet>> itemSets() async {
    final Database db = await getDBConnector();

    final List<Map<String, dynamic>> maps =
        await db.query('item_sets', orderBy: 'position');

    return List.generate(maps.length, (i) {
      return ItemSet(
          id: maps[i]['id'],
          name: maps[i]['name'],
          items: maps[i]['itemIds'].split("|"),
          position: maps[i]['position']);
    });
  }

  static Future<void> updateSetItems(Item item) async {
    final Database db = await getDBConnector();

    await db.update(
      'set_items',
      item.toMap(),
      //Ensure that the item has a matching id.
      where: 'id = ?',
      //Pass the item id as a whereArg to prevent SQL injection.
      whereArgs: [item.id],
    );
  }

  static Future<void> batchUpdateSetItems(List<Item> items) async {
    final Database db = await getDBConnector();

    for (Item item in items) {
      await db.update(
        'set_items',
        item.toMap(),
        //Ensure that the item has a matching id.
        where: 'id = ?',
        //Pass the item id as a whereArg to prevent SQL injection.
        whereArgs: [item.id],
      );
    }
  }

  static Future<void> updateItemSet(ItemSet preset) async {
    final Database db = await getDBConnector();

    await db.update(
      'item_sets',
      preset.toMap(),
      //Ensure that the item has a matching id.
      where: 'id = ?',
      //Pass the item id as a whereArg to prevent SQL injection.
      whereArgs: [preset.id],
    );
  }

  static Future<void> deleteSetItems(int id) async {
    final Database db = await getDBConnector();

    await db.delete(
      'set_items',
      //Use a 'where' clause to delete a specific item.
      where: 'id = ?',
      //pass the item's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  static Future<void> deleteItemSet(int id) async {
    final Database db = await getDBConnector();

    await db.delete(
      'item_sets',
      //Use a 'where' clause to delete a specific item.
      where: 'id = ?',
      //pass the item's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  static Future<void> batchDeleteItemSet(List<int> ids) async {
    final Database db = await getDBConnector();

    for (int id in ids) {
      await db.delete(
        'item_sets',
        //Use a 'where' clause to delete a specific item.
        where: 'id = ?',
        //pass the item's id as a whereArg to prevent SQL injection.
        whereArgs: [id],
      );
    }
  }

  static Future<void> nukeTable() async {
    final Database db = await getDBConnector();

    await db.execute("DROP TABLE IF EXISTS items");
  }
}
