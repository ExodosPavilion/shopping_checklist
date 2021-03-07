import 'package:moor_flutter/moor_flutter.dart';

part 'ChecklistDatabase.g.dart';

class Items extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get item => text().withLength(min: 1)();
  IntColumn get priority => integer()();
  BoolColumn get checked => boolean().withDefault(Constant(false))();
  IntColumn get position => integer()();
}

@UseMoor(tables: [Items], daos: [ItemDao])
class ChecklistDatabase extends _$ChecklistDatabase {
  ChecklistDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;
}

@UseDao(tables: [Items])
class ItemDao extends DatabaseAccessor<ChecklistDatabase> with _$ItemDaoMixin {
  final ChecklistDatabase db;

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
