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
  DateTimeColumn get checkedTime => dateTime().nullable()();
}

class Presets extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1)();
}

class SetItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get item => text().withLength(min: 1)();
  IntColumn get priority => integer()();
  BoolColumn get checked => boolean().withDefault(Constant(false))();
  IntColumn get position => integer().nullable()();
  IntColumn get presetId =>
      integer().customConstraint('REFERENCES Presets(id)')();
}

class HistoryItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get item => text().withLength(min: 1)();
  IntColumn get priority => integer()();
  BoolColumn get checked => boolean()();
  IntColumn get position => integer().nullable()();
  IntColumn get presetId =>
      integer().nullable().customConstraint('REFERENCES Presets(id)')();
  DateTimeColumn get checkedTime => dateTime()();
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
  tables: [Items, Presets, SetItems, HistoryItems],
  daos: [ItemDao, PresetDao, SetItemDao, HistoryItemDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        // Runs if the database has already been opened on the device with a lower version
        onUpgrade: (migrator, from, to) async {
          if (from == 1) {
            await migrator.addColumn(items, items.checkedTime);
            await migrator.createAll();
          } else if (from == 2) {
            await migrator.addColumn(items, items.checkedTime);
            await migrator.createTable(historyItems);
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}

@UseDao(tables: [Items])
class ItemDao extends DatabaseAccessor<AppDatabase> with _$ItemDaoMixin {
  final AppDatabase db;

  ItemDao(this.db) : super(db);

  Stream<List<Item>> watchAllItems() {
    return (select(items)).watch();
  }

  Stream<List<Item>> watchItemsSortedByNameAsc() {
    return (select(items)
          ..orderBy([
            (t) => OrderingTerm(expression: t.item, mode: OrderingMode.asc)
          ]))
        .watch();
  }

  Stream<List<Item>> watchItemsSortedByNameDesc() {
    return (select(items)
          ..orderBy([
            (t) => OrderingTerm(expression: t.item, mode: OrderingMode.desc)
          ]))
        .watch();
  }

  Stream<List<Item>> watchItemsSortedByPriorityAsc() {
    return (select(items)
          ..orderBy([
            (t) => OrderingTerm(expression: t.priority, mode: OrderingMode.asc)
          ]))
        .watch();
  }

  Stream<List<Item>> watchItemsSortedByPriorityDesc() {
    return (select(items)
          ..orderBy([
            (t) => OrderingTerm(expression: t.priority, mode: OrderingMode.desc)
          ]))
        .watch();
  }

  Stream<List<Item>> watchItemsSortedByPosition() {
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

@UseDao(tables: [Presets])
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

  Future<List<Preset>> getPresetId(String presetName) {
    return (select(presets)..where((t) => t.name.equals(presetName))).get();
  }
}

@UseDao(tables: [HistoryItems])
class HistoryItemDao extends DatabaseAccessor<AppDatabase>
    with _$HistoryItemDaoMixin {
  final AppDatabase db;

  HistoryItemDao(this.db) : super(db);

  Stream<List<HistoryItem>> watchAllHistoryItems() {
    return (select(historyItems)).watch();
  }

  Stream<List<HistoryItem>> watchHistoryItemsbyDateAsc() {
    return (select(historyItems)
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.checkedTime, mode: OrderingMode.asc)
          ]))
        .watch();
  }

  Stream<List<HistoryItem>> watchHistoryItemsbyDateDesc() {
    return (select(historyItems)
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.checkedTime, mode: OrderingMode.desc)
          ]))
        .watch();
  }

  Future<List<HistoryItem>> getHistoryItemsbyDate() {
    return (select(historyItems)
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.checkedTime, mode: OrderingMode.desc)
          ]))
        .get();
  }

  Future insertHistoryItem(Insertable<HistoryItem> historyItem) =>
      into(historyItems).insert(historyItem);

  Future updateHistoryItem(Insertable<HistoryItem> historyItem) =>
      update(historyItems).replace(historyItem);

  Future deleteHistoryItem(Insertable<HistoryItem> historyItem) =>
      delete(historyItems).delete(historyItem);
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
            leftOuterJoin(presets, presets.id.equalsExp(setItems.presetId)),
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
          ..where((t) => t.presetId.equals(preset.id))
          ..orderBy([
            (t) => OrderingTerm(expression: t.priority, mode: OrderingMode.desc)
          ]))
        .get();
  }

  Future insertSetItem(Insertable<SetItem> setItem) =>
      into(setItems).insert(setItem);

  Future updateSetItem(Insertable<SetItem> setItem) =>
      update(setItems).replace(setItem);

  Future deleteSetItem(Insertable<SetItem> setItem) =>
      delete(setItems).delete(setItem);
}
