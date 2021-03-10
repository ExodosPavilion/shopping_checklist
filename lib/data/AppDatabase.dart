import 'package:moor/moor.dart';
import 'package:moor/ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'AppDatabase.g.dart';

class Items extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get item => text().withLength(min: 1)();
  IntColumn get priority => integer()();
  BoolColumn get checked => boolean().withDefault(Constant(false))();
  IntColumn get position => integer()();
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Items], daos: [ItemDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

@UseDao(tables: [Items])
class ItemDao extends DatabaseAccessor<AppDatabase> with _$ItemDaoMixin {
  final AppDatabase db;

  ItemDao(this.db) : super(db);

  Future<List<Item>> getAllItems() {
    return (select(items)
          ..orderBy([
            (t) => OrderingTerm(expression: t.position, mode: OrderingMode.asc)
          ]))
        .get();
  }

  Stream<List<Item>> watchAllItems() {
    return (select(items)
          ..orderBy([
            (t) => OrderingTerm(expression: t.position, mode: OrderingMode.asc)
          ]))
        .watch();
  }

  Future insertItem(Insertable<Item> item) => into(items).insert(item);

  Future updateItem(Insertable<Item> item) => update(items).replace(item);

  Future deleteItem(Insertable<Item> item) => delete(items).delete(item);
}
