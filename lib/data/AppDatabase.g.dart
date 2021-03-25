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
  final DateTime checkedTime;
  Item(
      {@required this.id,
      @required this.item,
      @required this.priority,
      @required this.checked,
      @required this.position,
      this.checkedTime});
  factory Item.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Item(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      item: stringType.mapFromDatabaseResponse(data['${effectivePrefix}item']),
      priority:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}priority']),
      checked:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}checked']),
      position:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}position']),
      checkedTime: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}checked_time']),
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
    if (!nullToAbsent || checkedTime != null) {
      map['checked_time'] = Variable<DateTime>(checkedTime);
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
      checkedTime: checkedTime == null && nullToAbsent
          ? const Value.absent()
          : Value(checkedTime),
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
      checkedTime: serializer.fromJson<DateTime>(json['checkedTime']),
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
      'checkedTime': serializer.toJson<DateTime>(checkedTime),
    };
  }

  Item copyWith(
          {int id,
          String item,
          int priority,
          bool checked,
          int position,
          DateTime checkedTime}) =>
      Item(
        id: id ?? this.id,
        item: item ?? this.item,
        priority: priority ?? this.priority,
        checked: checked ?? this.checked,
        position: position ?? this.position,
        checkedTime: checkedTime ?? this.checkedTime,
      );
  @override
  String toString() {
    return (StringBuffer('Item(')
          ..write('id: $id, ')
          ..write('item: $item, ')
          ..write('priority: $priority, ')
          ..write('checked: $checked, ')
          ..write('position: $position, ')
          ..write('checkedTime: $checkedTime')
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
                  $mrjc(position.hashCode, checkedTime.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Item &&
          other.id == this.id &&
          other.item == this.item &&
          other.priority == this.priority &&
          other.checked == this.checked &&
          other.position == this.position &&
          other.checkedTime == this.checkedTime);
}

class ItemsCompanion extends UpdateCompanion<Item> {
  final Value<int> id;
  final Value<String> item;
  final Value<int> priority;
  final Value<bool> checked;
  final Value<int> position;
  final Value<DateTime> checkedTime;
  const ItemsCompanion({
    this.id = const Value.absent(),
    this.item = const Value.absent(),
    this.priority = const Value.absent(),
    this.checked = const Value.absent(),
    this.position = const Value.absent(),
    this.checkedTime = const Value.absent(),
  });
  ItemsCompanion.insert({
    this.id = const Value.absent(),
    @required String item,
    @required int priority,
    this.checked = const Value.absent(),
    @required int position,
    this.checkedTime = const Value.absent(),
  })  : item = Value(item),
        priority = Value(priority),
        position = Value(position);
  static Insertable<Item> custom({
    Expression<int> id,
    Expression<String> item,
    Expression<int> priority,
    Expression<bool> checked,
    Expression<int> position,
    Expression<DateTime> checkedTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (item != null) 'item': item,
      if (priority != null) 'priority': priority,
      if (checked != null) 'checked': checked,
      if (position != null) 'position': position,
      if (checkedTime != null) 'checked_time': checkedTime,
    });
  }

  ItemsCompanion copyWith(
      {Value<int> id,
      Value<String> item,
      Value<int> priority,
      Value<bool> checked,
      Value<int> position,
      Value<DateTime> checkedTime}) {
    return ItemsCompanion(
      id: id ?? this.id,
      item: item ?? this.item,
      priority: priority ?? this.priority,
      checked: checked ?? this.checked,
      position: position ?? this.position,
      checkedTime: checkedTime ?? this.checkedTime,
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
    if (checkedTime.present) {
      map['checked_time'] = Variable<DateTime>(checkedTime.value);
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
          ..write('position: $position, ')
          ..write('checkedTime: $checkedTime')
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

  final VerificationMeta _checkedTimeMeta =
      const VerificationMeta('checkedTime');
  GeneratedDateTimeColumn _checkedTime;
  @override
  GeneratedDateTimeColumn get checkedTime =>
      _checkedTime ??= _constructCheckedTime();
  GeneratedDateTimeColumn _constructCheckedTime() {
    return GeneratedDateTimeColumn(
      'checked_time',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, item, priority, checked, position, checkedTime];
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
    if (data.containsKey('checked_time')) {
      context.handle(
          _checkedTimeMeta,
          checkedTime.isAcceptableOrUnknown(
              data['checked_time'], _checkedTimeMeta));
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
  final int id;
  final String name;
  Preset({@required this.id, @required this.name});
  factory Preset.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Preset(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    return map;
  }

  PresetsCompanion toCompanion(bool nullToAbsent) {
    return PresetsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  factory Preset.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Preset(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Preset copyWith({int id, String name}) => Preset(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Preset(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, name.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Preset && other.id == this.id && other.name == this.name);
}

class PresetsCompanion extends UpdateCompanion<Preset> {
  final Value<int> id;
  final Value<String> name;
  const PresetsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  PresetsCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
  }) : name = Value(name);
  static Insertable<Preset> custom({
    Expression<int> id,
    Expression<String> name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  PresetsCompanion copyWith({Value<int> id, Value<String> name}) {
    return PresetsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PresetsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $PresetsTable extends Presets with TableInfo<$PresetsTable, Preset> {
  final GeneratedDatabase _db;
  final String _alias;
  $PresetsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false, minTextLength: 1);
  }

  @override
  List<GeneratedColumn> get $columns => [id, name];
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
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
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
  final int presetId;
  SetItem(
      {@required this.id,
      @required this.item,
      @required this.priority,
      @required this.checked,
      this.position,
      @required this.presetId});
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
      presetId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}preset_id']),
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
    if (!nullToAbsent || presetId != null) {
      map['preset_id'] = Variable<int>(presetId);
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
      presetId: presetId == null && nullToAbsent
          ? const Value.absent()
          : Value(presetId),
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
      presetId: serializer.fromJson<int>(json['presetId']),
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
      'presetId': serializer.toJson<int>(presetId),
    };
  }

  SetItem copyWith(
          {int id,
          String item,
          int priority,
          bool checked,
          int position,
          int presetId}) =>
      SetItem(
        id: id ?? this.id,
        item: item ?? this.item,
        priority: priority ?? this.priority,
        checked: checked ?? this.checked,
        position: position ?? this.position,
        presetId: presetId ?? this.presetId,
      );
  @override
  String toString() {
    return (StringBuffer('SetItem(')
          ..write('id: $id, ')
          ..write('item: $item, ')
          ..write('priority: $priority, ')
          ..write('checked: $checked, ')
          ..write('position: $position, ')
          ..write('presetId: $presetId')
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
                  $mrjc(position.hashCode, presetId.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is SetItem &&
          other.id == this.id &&
          other.item == this.item &&
          other.priority == this.priority &&
          other.checked == this.checked &&
          other.position == this.position &&
          other.presetId == this.presetId);
}

class SetItemsCompanion extends UpdateCompanion<SetItem> {
  final Value<int> id;
  final Value<String> item;
  final Value<int> priority;
  final Value<bool> checked;
  final Value<int> position;
  final Value<int> presetId;
  const SetItemsCompanion({
    this.id = const Value.absent(),
    this.item = const Value.absent(),
    this.priority = const Value.absent(),
    this.checked = const Value.absent(),
    this.position = const Value.absent(),
    this.presetId = const Value.absent(),
  });
  SetItemsCompanion.insert({
    this.id = const Value.absent(),
    @required String item,
    @required int priority,
    this.checked = const Value.absent(),
    this.position = const Value.absent(),
    @required int presetId,
  })  : item = Value(item),
        priority = Value(priority),
        presetId = Value(presetId);
  static Insertable<SetItem> custom({
    Expression<int> id,
    Expression<String> item,
    Expression<int> priority,
    Expression<bool> checked,
    Expression<int> position,
    Expression<int> presetId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (item != null) 'item': item,
      if (priority != null) 'priority': priority,
      if (checked != null) 'checked': checked,
      if (position != null) 'position': position,
      if (presetId != null) 'preset_id': presetId,
    });
  }

  SetItemsCompanion copyWith(
      {Value<int> id,
      Value<String> item,
      Value<int> priority,
      Value<bool> checked,
      Value<int> position,
      Value<int> presetId}) {
    return SetItemsCompanion(
      id: id ?? this.id,
      item: item ?? this.item,
      priority: priority ?? this.priority,
      checked: checked ?? this.checked,
      position: position ?? this.position,
      presetId: presetId ?? this.presetId,
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
    if (presetId.present) {
      map['preset_id'] = Variable<int>(presetId.value);
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
          ..write('presetId: $presetId')
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

  final VerificationMeta _presetIdMeta = const VerificationMeta('presetId');
  GeneratedIntColumn _presetId;
  @override
  GeneratedIntColumn get presetId => _presetId ??= _constructPresetId();
  GeneratedIntColumn _constructPresetId() {
    return GeneratedIntColumn('preset_id', $tableName, false,
        $customConstraints: 'REFERENCES Presets(id)');
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, item, priority, checked, position, presetId];
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
    if (data.containsKey('preset_id')) {
      context.handle(_presetIdMeta,
          presetId.isAcceptableOrUnknown(data['preset_id'], _presetIdMeta));
    } else if (isInserting) {
      context.missing(_presetIdMeta);
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

class HistoryItem extends DataClass implements Insertable<HistoryItem> {
  final int id;
  final String item;
  final int priority;
  final bool checked;
  final int position;
  final int presetId;
  final DateTime checkedTime;
  HistoryItem(
      {@required this.id,
      @required this.item,
      @required this.priority,
      @required this.checked,
      this.position,
      this.presetId,
      @required this.checkedTime});
  factory HistoryItem.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return HistoryItem(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      item: stringType.mapFromDatabaseResponse(data['${effectivePrefix}item']),
      priority:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}priority']),
      checked:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}checked']),
      position:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}position']),
      presetId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}preset_id']),
      checkedTime: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}checked_time']),
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
    if (!nullToAbsent || presetId != null) {
      map['preset_id'] = Variable<int>(presetId);
    }
    if (!nullToAbsent || checkedTime != null) {
      map['checked_time'] = Variable<DateTime>(checkedTime);
    }
    return map;
  }

  HistoryItemsCompanion toCompanion(bool nullToAbsent) {
    return HistoryItemsCompanion(
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
      presetId: presetId == null && nullToAbsent
          ? const Value.absent()
          : Value(presetId),
      checkedTime: checkedTime == null && nullToAbsent
          ? const Value.absent()
          : Value(checkedTime),
    );
  }

  factory HistoryItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return HistoryItem(
      id: serializer.fromJson<int>(json['id']),
      item: serializer.fromJson<String>(json['item']),
      priority: serializer.fromJson<int>(json['priority']),
      checked: serializer.fromJson<bool>(json['checked']),
      position: serializer.fromJson<int>(json['position']),
      presetId: serializer.fromJson<int>(json['presetId']),
      checkedTime: serializer.fromJson<DateTime>(json['checkedTime']),
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
      'presetId': serializer.toJson<int>(presetId),
      'checkedTime': serializer.toJson<DateTime>(checkedTime),
    };
  }

  HistoryItem copyWith(
          {int id,
          String item,
          int priority,
          bool checked,
          int position,
          int presetId,
          DateTime checkedTime}) =>
      HistoryItem(
        id: id ?? this.id,
        item: item ?? this.item,
        priority: priority ?? this.priority,
        checked: checked ?? this.checked,
        position: position ?? this.position,
        presetId: presetId ?? this.presetId,
        checkedTime: checkedTime ?? this.checkedTime,
      );
  @override
  String toString() {
    return (StringBuffer('HistoryItem(')
          ..write('id: $id, ')
          ..write('item: $item, ')
          ..write('priority: $priority, ')
          ..write('checked: $checked, ')
          ..write('position: $position, ')
          ..write('presetId: $presetId, ')
          ..write('checkedTime: $checkedTime')
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
              $mrjc(
                  checked.hashCode,
                  $mrjc(position.hashCode,
                      $mrjc(presetId.hashCode, checkedTime.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is HistoryItem &&
          other.id == this.id &&
          other.item == this.item &&
          other.priority == this.priority &&
          other.checked == this.checked &&
          other.position == this.position &&
          other.presetId == this.presetId &&
          other.checkedTime == this.checkedTime);
}

class HistoryItemsCompanion extends UpdateCompanion<HistoryItem> {
  final Value<int> id;
  final Value<String> item;
  final Value<int> priority;
  final Value<bool> checked;
  final Value<int> position;
  final Value<int> presetId;
  final Value<DateTime> checkedTime;
  const HistoryItemsCompanion({
    this.id = const Value.absent(),
    this.item = const Value.absent(),
    this.priority = const Value.absent(),
    this.checked = const Value.absent(),
    this.position = const Value.absent(),
    this.presetId = const Value.absent(),
    this.checkedTime = const Value.absent(),
  });
  HistoryItemsCompanion.insert({
    this.id = const Value.absent(),
    @required String item,
    @required int priority,
    @required bool checked,
    this.position = const Value.absent(),
    this.presetId = const Value.absent(),
    @required DateTime checkedTime,
  })  : item = Value(item),
        priority = Value(priority),
        checked = Value(checked),
        checkedTime = Value(checkedTime);
  static Insertable<HistoryItem> custom({
    Expression<int> id,
    Expression<String> item,
    Expression<int> priority,
    Expression<bool> checked,
    Expression<int> position,
    Expression<int> presetId,
    Expression<DateTime> checkedTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (item != null) 'item': item,
      if (priority != null) 'priority': priority,
      if (checked != null) 'checked': checked,
      if (position != null) 'position': position,
      if (presetId != null) 'preset_id': presetId,
      if (checkedTime != null) 'checked_time': checkedTime,
    });
  }

  HistoryItemsCompanion copyWith(
      {Value<int> id,
      Value<String> item,
      Value<int> priority,
      Value<bool> checked,
      Value<int> position,
      Value<int> presetId,
      Value<DateTime> checkedTime}) {
    return HistoryItemsCompanion(
      id: id ?? this.id,
      item: item ?? this.item,
      priority: priority ?? this.priority,
      checked: checked ?? this.checked,
      position: position ?? this.position,
      presetId: presetId ?? this.presetId,
      checkedTime: checkedTime ?? this.checkedTime,
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
    if (presetId.present) {
      map['preset_id'] = Variable<int>(presetId.value);
    }
    if (checkedTime.present) {
      map['checked_time'] = Variable<DateTime>(checkedTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistoryItemsCompanion(')
          ..write('id: $id, ')
          ..write('item: $item, ')
          ..write('priority: $priority, ')
          ..write('checked: $checked, ')
          ..write('position: $position, ')
          ..write('presetId: $presetId, ')
          ..write('checkedTime: $checkedTime')
          ..write(')'))
        .toString();
  }
}

class $HistoryItemsTable extends HistoryItems
    with TableInfo<$HistoryItemsTable, HistoryItem> {
  final GeneratedDatabase _db;
  final String _alias;
  $HistoryItemsTable(this._db, [this._alias]);
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
    return GeneratedBoolColumn(
      'checked',
      $tableName,
      false,
    );
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

  final VerificationMeta _presetIdMeta = const VerificationMeta('presetId');
  GeneratedIntColumn _presetId;
  @override
  GeneratedIntColumn get presetId => _presetId ??= _constructPresetId();
  GeneratedIntColumn _constructPresetId() {
    return GeneratedIntColumn('preset_id', $tableName, true,
        $customConstraints: 'REFERENCES Presets(id)');
  }

  final VerificationMeta _checkedTimeMeta =
      const VerificationMeta('checkedTime');
  GeneratedDateTimeColumn _checkedTime;
  @override
  GeneratedDateTimeColumn get checkedTime =>
      _checkedTime ??= _constructCheckedTime();
  GeneratedDateTimeColumn _constructCheckedTime() {
    return GeneratedDateTimeColumn(
      'checked_time',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, item, priority, checked, position, presetId, checkedTime];
  @override
  $HistoryItemsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'history_items';
  @override
  final String actualTableName = 'history_items';
  @override
  VerificationContext validateIntegrity(Insertable<HistoryItem> instance,
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
    } else if (isInserting) {
      context.missing(_checkedMeta);
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position'], _positionMeta));
    }
    if (data.containsKey('preset_id')) {
      context.handle(_presetIdMeta,
          presetId.isAcceptableOrUnknown(data['preset_id'], _presetIdMeta));
    }
    if (data.containsKey('checked_time')) {
      context.handle(
          _checkedTimeMeta,
          checkedTime.isAcceptableOrUnknown(
              data['checked_time'], _checkedTimeMeta));
    } else if (isInserting) {
      context.missing(_checkedTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HistoryItem map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return HistoryItem.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $HistoryItemsTable createAlias(String alias) {
    return $HistoryItemsTable(_db, alias);
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
  $HistoryItemsTable _historyItems;
  $HistoryItemsTable get historyItems =>
      _historyItems ??= $HistoryItemsTable(this);
  ItemDao _itemDao;
  ItemDao get itemDao => _itemDao ??= ItemDao(this as AppDatabase);
  PresetDao _presetDao;
  PresetDao get presetDao => _presetDao ??= PresetDao(this as AppDatabase);
  SetItemDao _setItemDao;
  SetItemDao get setItemDao => _setItemDao ??= SetItemDao(this as AppDatabase);
  HistoryItemDao _historyItemDao;
  HistoryItemDao get historyItemDao =>
      _historyItemDao ??= HistoryItemDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [items, presets, setItems, historyItems];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$ItemDaoMixin on DatabaseAccessor<AppDatabase> {
  $ItemsTable get items => attachedDatabase.items;
}
mixin _$PresetDaoMixin on DatabaseAccessor<AppDatabase> {
  $PresetsTable get presets => attachedDatabase.presets;
}
mixin _$HistoryItemDaoMixin on DatabaseAccessor<AppDatabase> {
  $HistoryItemsTable get historyItems => attachedDatabase.historyItems;
}
mixin _$SetItemDaoMixin on DatabaseAccessor<AppDatabase> {
  $SetItemsTable get setItems => attachedDatabase.setItems;
  $PresetsTable get presets => attachedDatabase.presets;
}
