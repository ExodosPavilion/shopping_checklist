// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppDatabase.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Item extends DataClass implements Insertable<Item> {
  final int id;
  final String item;
  final int priority;
  final bool checked;
  final int position;
  Item(
      {@required this.id,
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || item != null) {
      map['item'] = Variable<String>(item);
    }
    if (!nullToAbsent || priority != null) {
      map['priority'] = Variable<int>(priority);
    }
    if (!nullToAbsent || checked != null) {
      map['checked'] = Variable<bool>(checked);
    }
    if (!nullToAbsent || position != null) {
      map['position'] = Variable<int>(position);
    }
    return map;
  }

  ItemsCompanion toCompanion(bool nullToAbsent) {
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
    );
  }

  factory Item.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Item(
      id: serializer.fromJson<int>(json['id']),
      item: serializer.fromJson<String>(json['item']),
      priority: serializer.fromJson<int>(json['priority']),
      checked: serializer.fromJson<bool>(json['checked']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'item': serializer.toJson<String>(item),
      'priority': serializer.toJson<int>(priority),
      'checked': serializer.toJson<bool>(checked),
      'position': serializer.toJson<int>(position),
    };
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
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Item &&
          other.id == this.id &&
          other.item == this.item &&
          other.priority == this.priority &&
          other.checked == this.checked &&
          other.position == this.position);
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
  ItemsCompanion.insert({
    this.id = const Value.absent(),
    @required String item,
    @required int priority,
    this.checked = const Value.absent(),
    @required int position,
  })  : item = Value(item),
        priority = Value(priority),
        position = Value(position);
  static Insertable<Item> custom({
    Expression<int> id,
    Expression<String> item,
    Expression<int> priority,
    Expression<bool> checked,
    Expression<int> position,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (item != null) 'item': item,
      if (priority != null) 'priority': priority,
      if (checked != null) 'checked': checked,
      if (position != null) 'position': position,
    });
  }

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

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (item.present) {
      map['item'] = Variable<String>(item.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (checked.present) {
      map['checked'] = Variable<bool>(checked.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemsCompanion(')
          ..write('id: $id, ')
          ..write('item: $item, ')
          ..write('priority: $priority, ')
          ..write('checked: $checked, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
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
  VerificationContext validateIntegrity(Insertable<Item> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('item')) {
      context.handle(
          _itemMeta, item.isAcceptableOrUnknown(data['item'], _itemMeta));
    } else if (isInserting) {
      context.missing(_itemMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority'], _priorityMeta));
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('checked')) {
      context.handle(_checkedMeta,
          checked.isAcceptableOrUnknown(data['checked'], _checkedMeta));
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position'], _positionMeta));
    } else if (isInserting) {
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
  $ItemsTable createAlias(String alias) {
    return $ItemsTable(_db, alias);
  }
}

class Preset extends DataClass implements Insertable<Preset> {
  final String name;
  Preset({@required this.name});
  factory Preset.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return Preset(
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    return map;
  }

  PresetsCompanion toCompanion(bool nullToAbsent) {
    return PresetsCompanion(
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  factory Preset.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Preset(
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
    };
  }

  Preset copyWith({String name}) => Preset(
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Preset(')..write('name: $name')..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(name.hashCode);
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) || (other is Preset && other.name == this.name);
}

class PresetsCompanion extends UpdateCompanion<Preset> {
  final Value<String> name;
  const PresetsCompanion({
    this.name = const Value.absent(),
  });
  PresetsCompanion.insert({
    @required String name,
  }) : name = Value(name);
  static Insertable<Preset> custom({
    Expression<String> name,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
    });
  }

  PresetsCompanion copyWith({Value<String> name}) {
    return PresetsCompanion(
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PresetsCompanion(')..write('name: $name')..write(')'))
        .toString();
  }
}

class $PresetsTable extends Presets with TableInfo<$PresetsTable, Preset> {
  final GeneratedDatabase _db;
  final String _alias;
  $PresetsTable(this._db, [this._alias]);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false, minTextLength: 1);
  }

  @override
  List<GeneratedColumn> get $columns => [name];
  @override
  $PresetsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'presets';
  @override
  final String actualTableName = 'presets';
  @override
  VerificationContext validateIntegrity(Insertable<Preset> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  Preset map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Preset.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $PresetsTable createAlias(String alias) {
    return $PresetsTable(_db, alias);
  }
}

class SetItem extends DataClass implements Insertable<SetItem> {
  final int id;
  final String item;
  final int priority;
  final bool checked;
  final int position;
  final String presetName;
  SetItem(
      {@required this.id,
      @required this.item,
      @required this.priority,
      @required this.checked,
      this.position,
      @required this.presetName});
  factory SetItem.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return SetItem(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      item: stringType.mapFromDatabaseResponse(data['${effectivePrefix}item']),
      priority:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}priority']),
      checked:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}checked']),
      position:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}position']),
      presetName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}preset_name']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || item != null) {
      map['item'] = Variable<String>(item);
    }
    if (!nullToAbsent || priority != null) {
      map['priority'] = Variable<int>(priority);
    }
    if (!nullToAbsent || checked != null) {
      map['checked'] = Variable<bool>(checked);
    }
    if (!nullToAbsent || position != null) {
      map['position'] = Variable<int>(position);
    }
    if (!nullToAbsent || presetName != null) {
      map['preset_name'] = Variable<String>(presetName);
    }
    return map;
  }

  SetItemsCompanion toCompanion(bool nullToAbsent) {
    return SetItemsCompanion(
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
      presetName: presetName == null && nullToAbsent
          ? const Value.absent()
          : Value(presetName),
    );
  }

  factory SetItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return SetItem(
      id: serializer.fromJson<int>(json['id']),
      item: serializer.fromJson<String>(json['item']),
      priority: serializer.fromJson<int>(json['priority']),
      checked: serializer.fromJson<bool>(json['checked']),
      position: serializer.fromJson<int>(json['position']),
      presetName: serializer.fromJson<String>(json['presetName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'item': serializer.toJson<String>(item),
      'priority': serializer.toJson<int>(priority),
      'checked': serializer.toJson<bool>(checked),
      'position': serializer.toJson<int>(position),
      'presetName': serializer.toJson<String>(presetName),
    };
  }

  SetItem copyWith(
          {int id,
          String item,
          int priority,
          bool checked,
          int position,
          String presetName}) =>
      SetItem(
        id: id ?? this.id,
        item: item ?? this.item,
        priority: priority ?? this.priority,
        checked: checked ?? this.checked,
        position: position ?? this.position,
        presetName: presetName ?? this.presetName,
      );
  @override
  String toString() {
    return (StringBuffer('SetItem(')
          ..write('id: $id, ')
          ..write('item: $item, ')
          ..write('priority: $priority, ')
          ..write('checked: $checked, ')
          ..write('position: $position, ')
          ..write('presetName: $presetName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          item.hashCode,
          $mrjc(
              priority.hashCode,
              $mrjc(checked.hashCode,
                  $mrjc(position.hashCode, presetName.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is SetItem &&
          other.id == this.id &&
          other.item == this.item &&
          other.priority == this.priority &&
          other.checked == this.checked &&
          other.position == this.position &&
          other.presetName == this.presetName);
}

class SetItemsCompanion extends UpdateCompanion<SetItem> {
  final Value<int> id;
  final Value<String> item;
  final Value<int> priority;
  final Value<bool> checked;
  final Value<int> position;
  final Value<String> presetName;
  const SetItemsCompanion({
    this.id = const Value.absent(),
    this.item = const Value.absent(),
    this.priority = const Value.absent(),
    this.checked = const Value.absent(),
    this.position = const Value.absent(),
    this.presetName = const Value.absent(),
  });
  SetItemsCompanion.insert({
    this.id = const Value.absent(),
    @required String item,
    @required int priority,
    this.checked = const Value.absent(),
    this.position = const Value.absent(),
    @required String presetName,
  })  : item = Value(item),
        priority = Value(priority),
        presetName = Value(presetName);
  static Insertable<SetItem> custom({
    Expression<int> id,
    Expression<String> item,
    Expression<int> priority,
    Expression<bool> checked,
    Expression<int> position,
    Expression<String> presetName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (item != null) 'item': item,
      if (priority != null) 'priority': priority,
      if (checked != null) 'checked': checked,
      if (position != null) 'position': position,
      if (presetName != null) 'preset_name': presetName,
    });
  }

  SetItemsCompanion copyWith(
      {Value<int> id,
      Value<String> item,
      Value<int> priority,
      Value<bool> checked,
      Value<int> position,
      Value<String> presetName}) {
    return SetItemsCompanion(
      id: id ?? this.id,
      item: item ?? this.item,
      priority: priority ?? this.priority,
      checked: checked ?? this.checked,
      position: position ?? this.position,
      presetName: presetName ?? this.presetName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (item.present) {
      map['item'] = Variable<String>(item.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (checked.present) {
      map['checked'] = Variable<bool>(checked.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (presetName.present) {
      map['preset_name'] = Variable<String>(presetName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SetItemsCompanion(')
          ..write('id: $id, ')
          ..write('item: $item, ')
          ..write('priority: $priority, ')
          ..write('checked: $checked, ')
          ..write('position: $position, ')
          ..write('presetName: $presetName')
          ..write(')'))
        .toString();
  }
}

class $SetItemsTable extends SetItems with TableInfo<$SetItemsTable, SetItem> {
  final GeneratedDatabase _db;
  final String _alias;
  $SetItemsTable(this._db, [this._alias]);
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
      true,
    );
  }

  final VerificationMeta _presetNameMeta = const VerificationMeta('presetName');
  GeneratedTextColumn _presetName;
  @override
  GeneratedTextColumn get presetName => _presetName ??= _constructPresetName();
  GeneratedTextColumn _constructPresetName() {
    return GeneratedTextColumn('preset_name', $tableName, false,
        $customConstraints: 'REFERENCES Presets(name)');
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, item, priority, checked, position, presetName];
  @override
  $SetItemsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'set_items';
  @override
  final String actualTableName = 'set_items';
  @override
  VerificationContext validateIntegrity(Insertable<SetItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('item')) {
      context.handle(
          _itemMeta, item.isAcceptableOrUnknown(data['item'], _itemMeta));
    } else if (isInserting) {
      context.missing(_itemMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority'], _priorityMeta));
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('checked')) {
      context.handle(_checkedMeta,
          checked.isAcceptableOrUnknown(data['checked'], _checkedMeta));
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position'], _positionMeta));
    }
    if (data.containsKey('preset_name')) {
      context.handle(
          _presetNameMeta,
          presetName.isAcceptableOrUnknown(
              data['preset_name'], _presetNameMeta));
    } else if (isInserting) {
      context.missing(_presetNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SetItem map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return SetItem.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $SetItemsTable createAlias(String alias) {
    return $SetItemsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $ItemsTable _items;
  $ItemsTable get items => _items ??= $ItemsTable(this);
  $PresetsTable _presets;
  $PresetsTable get presets => _presets ??= $PresetsTable(this);
  $SetItemsTable _setItems;
  $SetItemsTable get setItems => _setItems ??= $SetItemsTable(this);
  ItemDao _itemDao;
  ItemDao get itemDao => _itemDao ??= ItemDao(this as AppDatabase);
  PresetDao _presetDao;
  PresetDao get presetDao => _presetDao ??= PresetDao(this as AppDatabase);
  SetItemDao _setItemDao;
  SetItemDao get setItemDao => _setItemDao ??= SetItemDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [items, presets, setItems];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$ItemDaoMixin on DatabaseAccessor<AppDatabase> {
  $ItemsTable get items => attachedDatabase.items;
}
mixin _$PresetDaoMixin on DatabaseAccessor<AppDatabase> {
  $PresetsTable get presets => attachedDatabase.presets;
  $SetItemsTable get setItems => attachedDatabase.setItems;
}
mixin _$SetItemDaoMixin on DatabaseAccessor<AppDatabase> {
  $SetItemsTable get setItems => attachedDatabase.setItems;
  $PresetsTable get presets => attachedDatabase.presets;
}
