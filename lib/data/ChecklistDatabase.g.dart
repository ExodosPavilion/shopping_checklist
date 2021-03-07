// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChecklistDatabase.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps
class Item extends DataClass implements Insertable<Item> {
  final int id;
  String item;
  int priority;
  bool checked;
  int position;
  Item(
      {this.id,
      @required this.item,
      @required this.priority,
      @required this.checked,
      @required this.position});
  factory Item.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Item(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      item: stringType.mapFromDatabaseResponse(data['${effectivePrefix}item']),
      priority:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}priority']),
      checked:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}checked']),
      position:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}position']),
    );
  }
  factory Item.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Item(
      id: serializer.fromJson<int>(json['id']),
      item: serializer.fromJson<String>(json['item']),
      priority: serializer.fromJson<int>(json['priority']),
      checked: serializer.fromJson<bool>(json['checked']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'item': serializer.toJson<String>(item),
      'priority': serializer.toJson<int>(priority),
      'checked': serializer.toJson<bool>(checked),
      'position': serializer.toJson<int>(position),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Item>>(bool nullToAbsent) {
    return ItemsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      item: item == null && nullToAbsent ? const Value.absent() : Value(item),
      priority: priority == null && nullToAbsent
          ? const Value.absent()
          : Value(priority),
      checked: checked == null && nullToAbsent
          ? const Value.absent()
          : Value(checked),
      position: position == null && nullToAbsent
          ? const Value.absent()
          : Value(position),
    ) as T;
  }

  Item copyWith(
          {int id, String item, int priority, bool checked, int position}) =>
      Item(
        id: id ?? this.id,
        item: item ?? this.item,
        priority: priority ?? this.priority,
        checked: checked ?? this.checked,
        position: position ?? this.position,
      );
  @override
  String toString() {
    return (StringBuffer('Item(')
          ..write('id: $id, ')
          ..write('item: $item, ')
          ..write('priority: $priority, ')
          ..write('checked: $checked, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          item.hashCode,
          $mrjc(
              priority.hashCode, $mrjc(checked.hashCode, position.hashCode)))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Item &&
          other.id == id &&
          other.item == item &&
          other.priority == priority &&
          other.checked == checked &&
          other.position == position);
}

class ItemsCompanion extends UpdateCompanion<Item> {
  final Value<int> id;
  final Value<String> item;
  final Value<int> priority;
  final Value<bool> checked;
  final Value<int> position;
  const ItemsCompanion({
    this.id = const Value.absent(),
    this.item = const Value.absent(),
    this.priority = const Value.absent(),
    this.checked = const Value.absent(),
    this.position = const Value.absent(),
  });
  ItemsCompanion copyWith(
      {Value<int> id,
      Value<String> item,
      Value<int> priority,
      Value<bool> checked,
      Value<int> position}) {
    return ItemsCompanion(
      id: id ?? this.id,
      item: item ?? this.item,
      priority: priority ?? this.priority,
      checked: checked ?? this.checked,
      position: position ?? this.position,
    );
  }
}

class $ItemsTable extends Items with TableInfo<$ItemsTable, Item> {
  final GeneratedDatabase _db;
  final String _alias;
  $ItemsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _itemMeta = const VerificationMeta('item');
  GeneratedTextColumn _item;
  @override
  GeneratedTextColumn get item => _item ??= _constructItem();
  GeneratedTextColumn _constructItem() {
    return GeneratedTextColumn('item', $tableName, false, minTextLength: 1);
  }

  final VerificationMeta _priorityMeta = const VerificationMeta('priority');
  GeneratedIntColumn _priority;
  @override
  GeneratedIntColumn get priority => _priority ??= _constructPriority();
  GeneratedIntColumn _constructPriority() {
    return GeneratedIntColumn(
      'priority',
      $tableName,
      false,
    );
  }

  final VerificationMeta _checkedMeta = const VerificationMeta('checked');
  GeneratedBoolColumn _checked;
  @override
  GeneratedBoolColumn get checked => _checked ??= _constructChecked();
  GeneratedBoolColumn _constructChecked() {
    return GeneratedBoolColumn('checked', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _positionMeta = const VerificationMeta('position');
  GeneratedIntColumn _position;
  @override
  GeneratedIntColumn get position => _position ??= _constructPosition();
  GeneratedIntColumn _constructPosition() {
    return GeneratedIntColumn(
      'position',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, item, priority, checked, position];
  @override
  $ItemsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'items';
  @override
  final String actualTableName = 'items';
  @override
  VerificationContext validateIntegrity(ItemsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.item.present) {
      context.handle(
          _itemMeta, item.isAcceptableValue(d.item.value, _itemMeta));
    } else if (item.isRequired && isInserting) {
      context.missing(_itemMeta);
    }
    if (d.priority.present) {
      context.handle(_priorityMeta,
          priority.isAcceptableValue(d.priority.value, _priorityMeta));
    } else if (priority.isRequired && isInserting) {
      context.missing(_priorityMeta);
    }
    if (d.checked.present) {
      context.handle(_checkedMeta,
          checked.isAcceptableValue(d.checked.value, _checkedMeta));
    } else if (checked.isRequired && isInserting) {
      context.missing(_checkedMeta);
    }
    if (d.position.present) {
      context.handle(_positionMeta,
          position.isAcceptableValue(d.position.value, _positionMeta));
    } else if (position.isRequired && isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Item map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Item.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ItemsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.item.present) {
      map['item'] = Variable<String, StringType>(d.item.value);
    }
    if (d.priority.present) {
      map['priority'] = Variable<int, IntType>(d.priority.value);
    }
    if (d.checked.present) {
      map['checked'] = Variable<bool, BoolType>(d.checked.value);
    }
    if (d.position.present) {
      map['position'] = Variable<int, IntType>(d.position.value);
    }
    return map;
  }

  @override
  $ItemsTable createAlias(String alias) {
    return $ItemsTable(_db, alias);
  }
}

abstract class _$ChecklistDatabase extends GeneratedDatabase {
  _$ChecklistDatabase(QueryExecutor e)
      : super(const SqlTypeSystem.withDefaults(), e);
  $ItemsTable _items;
  $ItemsTable get items => _items ??= $ItemsTable(this);
  ItemDao _itemDao;
  ItemDao get itemDao => _itemDao ??= ItemDao(this as ChecklistDatabase);
  @override
  List<TableInfo> get allTables => [items];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$ItemDaoMixin on DatabaseAccessor<ChecklistDatabase> {
  $ItemsTable get items => db.items;
}
