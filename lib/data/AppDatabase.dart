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

class Presets extends Table {
  TextColumn get name => text().withLength(min: 1)();

  @override
  Set<Column> get primaryKey => {name};
}

class SetItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get item => text().withLength(min: 1)();
  IntColumn get priority => integer()();
  BoolColumn get checked => boolean().withDefault(Constant(false))();
  IntColumn get position => integer().nullable()();
  TextColumn get presetName =>
      text().customConstraint('REFERENCES Presets(name)')();
}

class ItemSet extends Table {
  Preset preset;
  List<SetItem> setItems;

  ItemSet({@required this.preset, @required this.setItems});
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file, logStatements: true);
  });
}

@UseMoor(
    tables: [Items, Presets, SetItems], daos: [ItemDao, PresetDao, SetItemDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
          // Runs if the database has already been opened on the device with a lower version
          onUpgrade: (migrator, from, to) async {
        if (from == 1) {
          await migrator.createAll();
        }
      }, beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      });
}

@UseDao(tables: [Items])
class ItemDao extends DatabaseAccessor<AppDatabase> with _$ItemDaoMixin {
  final AppDatabase db;

  ItemDao(this.db) : super(db);

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

@UseDao(tables: [Presets, SetItems])
class PresetDao extends DatabaseAccessor<AppDatabase> with _$PresetDaoMixin {
  final AppDatabase db;

  PresetDao(this.db) : super(db);

  Stream<List<Preset>> watchAllItems() {
    return (select(presets)
          ..orderBy([
            (t) => OrderingTerm(expression: t.name, mode: OrderingMode.asc)
          ]))
        .watch();
  }

  Future insertPreset(Insertable<Preset> preset) =>
      into(presets).insert(preset);

  Future updatePreset(Insertable<Preset> preset) =>
      update(presets).replace(preset);

  Future deletePreset(Insertable<Preset> preset) =>
      delete(presets).delete(preset);
}

@UseDao(tables: [SetItems, Presets])
class SetItemDao extends DatabaseAccessor<AppDatabase> with _$SetItemDaoMixin {
  final AppDatabase db;

  SetItemDao(this.db) : super(db);

  Stream<List<ItemSet>> watchAllSetItems() {
    return (select(setItems)
          ..orderBy([
            (t) => OrderingTerm(expression: t.priority, mode: OrderingMode.asc)
          ]))
        .join(
          [
            leftOuterJoin(presets, presets.name.equalsExp(setItems.presetName)),
          ],
        )
        .watch()
        .map((rows) {
          //https://stackoverflow.com/questions/60252122/how-to-create-flutter-moor-relationship-with-one-to-many-join
          final groupedData = <Preset, List<SetItem>>{};

          for (final row in rows) {
            final preset = row.readTable(presets);
            final setItem = row.readTable(setItems);

            final list = groupedData.putIfAbsent(preset, () => []);
            if (setItem != null) list.add(setItem);
          }

          return [
            for (final entry in groupedData.entries)
              ItemSet(preset: entry.key, setItems: entry.value)
          ];
        });
  }

  Future<List<SetItem>> getItemsforPreset(Preset preset) {
    return (select(setItems)
          ..orderBy([
            (t) => OrderingTerm(expression: t.priority, mode: OrderingMode.asc)
          ])
          ..where((t) => t.presetName.equals(preset.name)))
        .get();
  }

  Future insertSetItem(Insertable<SetItem> setItem) =>
      into(setItems).insert(setItem);

  Future updateSetItem(Insertable<SetItem> setItem) =>
      update(setItems).replace(setItem);

  Future deleteSetItem(Insertable<SetItem> setItem) =>
      delete(setItems).delete(setItem);
}
