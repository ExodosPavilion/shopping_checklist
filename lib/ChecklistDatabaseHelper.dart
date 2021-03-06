import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'Item.dart';

class ChecklistDatabaseHelper {
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
      join(await getDatabasesPath(), "items.db"),
      onCreate: (db, version) async {
        return db.execute(
          "CREATE TABLE items(id INTEGER PRIMARY KEY AUTOINCREMENT, item TEXT, priority INTEGER, checked INTEGER, position INTEGER)",
        );
      },
      version: 1,
    );

    return _database;
  }

  static Future<void> insertItem(Item item) async {
    final Database db = await getDBConnector();

    await db.insert('items', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Item>> items() async {
    final Database db = await getDBConnector();

    final List<Map<String, dynamic>> maps =
        await db.query('items', orderBy: 'position');

    return List.generate(maps.length, (i) {
      return Item(
        id: maps[i]['id'],
        item: maps[i]['item'],
        priority: maps[i]['priority'],
        checked: maps[i]['checked'] == 0 ? false : true,
        position: maps[i]['position'],
      );
    });
  }

  static Future<void> updateItem(Item item) async {
    final Database db = await getDBConnector();

    await db.update(
      'items',
      item.toMap(),
      //Ensure that the item has a matching id.
      where: 'id = ?',
      //Pass the item id as a whereArg to prevent SQL injection.
      whereArgs: [item.id],
    );
  }

  static Future<void> deleteItem(int id) async {
    final Database db = await getDBConnector();

    await db.delete(
      'items',
      //Use a 'where' clause to delete a specific item.
      where: 'id = ?',
      //pass the item's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  static Future<void> nukeTable() async {
    final Database db = await getDBConnector();

    await db.execute("DROP TABLE IF EXISTS items");
  }
}
