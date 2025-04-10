// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ConfigStructureTableTable extends ConfigStructureTable
    with TableInfo<$ConfigStructureTableTable, ConfigStructureTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConfigStructureTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<ConfigStructure, Uint8List>
  content = GeneratedColumn<Uint8List>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  ).withConverter<ConfigStructure>(
    $ConfigStructureTableTable.$convertercontent,
  );
  @override
  List<GeneratedColumn> get $columns => [id, content];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'config_structure_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ConfigStructureTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ConfigStructureTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConfigStructureTableData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      content: $ConfigStructureTableTable.$convertercontent.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.blob,
          data['${effectivePrefix}content'],
        )!,
      ),
    );
  }

  @override
  $ConfigStructureTableTable createAlias(String alias) {
    return $ConfigStructureTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ConfigStructure, Uint8List, Object?>
  $convertercontent = ConfigStructure.binaryConverter;
}

class ConfigStructureTableData extends DataClass
    implements Insertable<ConfigStructureTableData> {
  final int id;
  final ConfigStructure content;
  const ConfigStructureTableData({required this.id, required this.content});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['content'] = Variable<Uint8List>(
        $ConfigStructureTableTable.$convertercontent.toSql(content),
      );
    }
    return map;
  }

  ConfigStructureTableCompanion toCompanion(bool nullToAbsent) {
    return ConfigStructureTableCompanion(
      id: Value(id),
      content: Value(content),
    );
  }

  factory ConfigStructureTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConfigStructureTableData(
      id: serializer.fromJson<int>(json['id']),
      content: $ConfigStructureTableTable.$convertercontent.fromJson(
        serializer.fromJson<Object?>(json['content']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'content': serializer.toJson<Object?>(
        $ConfigStructureTableTable.$convertercontent.toJson(content),
      ),
    };
  }

  ConfigStructureTableData copyWith({int? id, ConfigStructure? content}) =>
      ConfigStructureTableData(
        id: id ?? this.id,
        content: content ?? this.content,
      );
  ConfigStructureTableData copyWithCompanion(
    ConfigStructureTableCompanion data,
  ) {
    return ConfigStructureTableData(
      id: data.id.present ? data.id.value : this.id,
      content: data.content.present ? data.content.value : this.content,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConfigStructureTableData(')
          ..write('id: $id, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, content);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConfigStructureTableData &&
          other.id == this.id &&
          other.content == this.content);
}

class ConfigStructureTableCompanion
    extends UpdateCompanion<ConfigStructureTableData> {
  final Value<int> id;
  final Value<ConfigStructure> content;
  const ConfigStructureTableCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
  });
  ConfigStructureTableCompanion.insert({
    this.id = const Value.absent(),
    required ConfigStructure content,
  }) : content = Value(content);
  static Insertable<ConfigStructureTableData> custom({
    Expression<int>? id,
    Expression<Uint8List>? content,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
    });
  }

  ConfigStructureTableCompanion copyWith({
    Value<int>? id,
    Value<ConfigStructure>? content,
  }) {
    return ConfigStructureTableCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (content.present) {
      map['content'] = Variable<Uint8List>(
        $ConfigStructureTableTable.$convertercontent.toSql(content.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConfigStructureTableCompanion(')
          ..write('id: $id, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }
}

class $StructureComponentTableTable extends StructureComponentTable
    with TableInfo<$StructureComponentTableTable, StructureComponentTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StructureComponentTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tagNameMeta = const VerificationMeta(
    'tagName',
  );
  @override
  late final GeneratedColumn<String> tagName = GeneratedColumn<String>(
    'tag_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _digitsMeta = const VerificationMeta('digits');
  @override
  late final GeneratedColumn<int> digits = GeneratedColumn<int>(
    'digits',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastUpdateTimeMeta = const VerificationMeta(
    'lastUpdateTime',
  );
  @override
  late final GeneratedColumn<String> lastUpdateTime = GeneratedColumn<String>(
    'last_update_time',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _validMeta = const VerificationMeta('valid');
  @override
  late final GeneratedColumn<bool> valid = GeneratedColumn<bool>(
    'valid',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("valid" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    type,
    tagName,
    description,
    unit,
    digits,
    value,
    lastUpdateTime,
    valid,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'structure_component_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<StructureComponentTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('tag_name')) {
      context.handle(
        _tagNameMeta,
        tagName.isAcceptableOrUnknown(data['tag_name']!, _tagNameMeta),
      );
    } else if (isInserting) {
      context.missing(_tagNameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('digits')) {
      context.handle(
        _digitsMeta,
        digits.isAcceptableOrUnknown(data['digits']!, _digitsMeta),
      );
    } else if (isInserting) {
      context.missing(_digitsMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    }
    if (data.containsKey('last_update_time')) {
      context.handle(
        _lastUpdateTimeMeta,
        lastUpdateTime.isAcceptableOrUnknown(
          data['last_update_time']!,
          _lastUpdateTimeMeta,
        ),
      );
    }
    if (data.containsKey('valid')) {
      context.handle(
        _validMeta,
        valid.isAcceptableOrUnknown(data['valid']!, _validMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  StructureComponentTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StructureComponentTableData(
      type:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}type'],
          )!,
      tagName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}tag_name'],
          )!,
      description:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}description'],
          )!,
      unit:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}unit'],
          )!,
      digits:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}digits'],
          )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      ),
      lastUpdateTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_update_time'],
      ),
      valid: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}valid'],
      ),
    );
  }

  @override
  $StructureComponentTableTable createAlias(String alias) {
    return $StructureComponentTableTable(attachedDatabase, alias);
  }
}

class StructureComponentTableData extends DataClass
    implements Insertable<StructureComponentTableData> {
  final String type;
  final String tagName;
  final String description;
  final String unit;
  final int digits;
  final String? value;
  final String? lastUpdateTime;
  final bool? valid;
  const StructureComponentTableData({
    required this.type,
    required this.tagName,
    required this.description,
    required this.unit,
    required this.digits,
    this.value,
    this.lastUpdateTime,
    this.valid,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['type'] = Variable<String>(type);
    map['tag_name'] = Variable<String>(tagName);
    map['description'] = Variable<String>(description);
    map['unit'] = Variable<String>(unit);
    map['digits'] = Variable<int>(digits);
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<String>(value);
    }
    if (!nullToAbsent || lastUpdateTime != null) {
      map['last_update_time'] = Variable<String>(lastUpdateTime);
    }
    if (!nullToAbsent || valid != null) {
      map['valid'] = Variable<bool>(valid);
    }
    return map;
  }

  StructureComponentTableCompanion toCompanion(bool nullToAbsent) {
    return StructureComponentTableCompanion(
      type: Value(type),
      tagName: Value(tagName),
      description: Value(description),
      unit: Value(unit),
      digits: Value(digits),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
      lastUpdateTime:
          lastUpdateTime == null && nullToAbsent
              ? const Value.absent()
              : Value(lastUpdateTime),
      valid:
          valid == null && nullToAbsent ? const Value.absent() : Value(valid),
    );
  }

  factory StructureComponentTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StructureComponentTableData(
      type: serializer.fromJson<String>(json['type']),
      tagName: serializer.fromJson<String>(json['tagName']),
      description: serializer.fromJson<String>(json['description']),
      unit: serializer.fromJson<String>(json['unit']),
      digits: serializer.fromJson<int>(json['digits']),
      value: serializer.fromJson<String?>(json['value']),
      lastUpdateTime: serializer.fromJson<String?>(json['lastUpdateTime']),
      valid: serializer.fromJson<bool?>(json['valid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'type': serializer.toJson<String>(type),
      'tagName': serializer.toJson<String>(tagName),
      'description': serializer.toJson<String>(description),
      'unit': serializer.toJson<String>(unit),
      'digits': serializer.toJson<int>(digits),
      'value': serializer.toJson<String?>(value),
      'lastUpdateTime': serializer.toJson<String?>(lastUpdateTime),
      'valid': serializer.toJson<bool?>(valid),
    };
  }

  StructureComponentTableData copyWith({
    String? type,
    String? tagName,
    String? description,
    String? unit,
    int? digits,
    Value<String?> value = const Value.absent(),
    Value<String?> lastUpdateTime = const Value.absent(),
    Value<bool?> valid = const Value.absent(),
  }) => StructureComponentTableData(
    type: type ?? this.type,
    tagName: tagName ?? this.tagName,
    description: description ?? this.description,
    unit: unit ?? this.unit,
    digits: digits ?? this.digits,
    value: value.present ? value.value : this.value,
    lastUpdateTime:
        lastUpdateTime.present ? lastUpdateTime.value : this.lastUpdateTime,
    valid: valid.present ? valid.value : this.valid,
  );
  StructureComponentTableData copyWithCompanion(
    StructureComponentTableCompanion data,
  ) {
    return StructureComponentTableData(
      type: data.type.present ? data.type.value : this.type,
      tagName: data.tagName.present ? data.tagName.value : this.tagName,
      description:
          data.description.present ? data.description.value : this.description,
      unit: data.unit.present ? data.unit.value : this.unit,
      digits: data.digits.present ? data.digits.value : this.digits,
      value: data.value.present ? data.value.value : this.value,
      lastUpdateTime:
          data.lastUpdateTime.present
              ? data.lastUpdateTime.value
              : this.lastUpdateTime,
      valid: data.valid.present ? data.valid.value : this.valid,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StructureComponentTableData(')
          ..write('type: $type, ')
          ..write('tagName: $tagName, ')
          ..write('description: $description, ')
          ..write('unit: $unit, ')
          ..write('digits: $digits, ')
          ..write('value: $value, ')
          ..write('lastUpdateTime: $lastUpdateTime, ')
          ..write('valid: $valid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    type,
    tagName,
    description,
    unit,
    digits,
    value,
    lastUpdateTime,
    valid,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StructureComponentTableData &&
          other.type == this.type &&
          other.tagName == this.tagName &&
          other.description == this.description &&
          other.unit == this.unit &&
          other.digits == this.digits &&
          other.value == this.value &&
          other.lastUpdateTime == this.lastUpdateTime &&
          other.valid == this.valid);
}

class StructureComponentTableCompanion
    extends UpdateCompanion<StructureComponentTableData> {
  final Value<String> type;
  final Value<String> tagName;
  final Value<String> description;
  final Value<String> unit;
  final Value<int> digits;
  final Value<String?> value;
  final Value<String?> lastUpdateTime;
  final Value<bool?> valid;
  final Value<int> rowid;
  const StructureComponentTableCompanion({
    this.type = const Value.absent(),
    this.tagName = const Value.absent(),
    this.description = const Value.absent(),
    this.unit = const Value.absent(),
    this.digits = const Value.absent(),
    this.value = const Value.absent(),
    this.lastUpdateTime = const Value.absent(),
    this.valid = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StructureComponentTableCompanion.insert({
    required String type,
    required String tagName,
    required String description,
    required String unit,
    required int digits,
    this.value = const Value.absent(),
    this.lastUpdateTime = const Value.absent(),
    this.valid = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : type = Value(type),
       tagName = Value(tagName),
       description = Value(description),
       unit = Value(unit),
       digits = Value(digits);
  static Insertable<StructureComponentTableData> custom({
    Expression<String>? type,
    Expression<String>? tagName,
    Expression<String>? description,
    Expression<String>? unit,
    Expression<int>? digits,
    Expression<String>? value,
    Expression<String>? lastUpdateTime,
    Expression<bool>? valid,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (type != null) 'type': type,
      if (tagName != null) 'tag_name': tagName,
      if (description != null) 'description': description,
      if (unit != null) 'unit': unit,
      if (digits != null) 'digits': digits,
      if (value != null) 'value': value,
      if (lastUpdateTime != null) 'last_update_time': lastUpdateTime,
      if (valid != null) 'valid': valid,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StructureComponentTableCompanion copyWith({
    Value<String>? type,
    Value<String>? tagName,
    Value<String>? description,
    Value<String>? unit,
    Value<int>? digits,
    Value<String?>? value,
    Value<String?>? lastUpdateTime,
    Value<bool?>? valid,
    Value<int>? rowid,
  }) {
    return StructureComponentTableCompanion(
      type: type ?? this.type,
      tagName: tagName ?? this.tagName,
      description: description ?? this.description,
      unit: unit ?? this.unit,
      digits: digits ?? this.digits,
      value: value ?? this.value,
      lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
      valid: valid ?? this.valid,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (tagName.present) {
      map['tag_name'] = Variable<String>(tagName.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (digits.present) {
      map['digits'] = Variable<int>(digits.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (lastUpdateTime.present) {
      map['last_update_time'] = Variable<String>(lastUpdateTime.value);
    }
    if (valid.present) {
      map['valid'] = Variable<bool>(valid.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StructureComponentTableCompanion(')
          ..write('type: $type, ')
          ..write('tagName: $tagName, ')
          ..write('description: $description, ')
          ..write('unit: $unit, ')
          ..write('digits: $digits, ')
          ..write('value: $value, ')
          ..write('lastUpdateTime: $lastUpdateTime, ')
          ..write('valid: $valid, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ConfigStructureTableTable configStructureTable =
      $ConfigStructureTableTable(this);
  late final $StructureComponentTableTable structureComponentTable =
      $StructureComponentTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    configStructureTable,
    structureComponentTable,
  ];
}

typedef $$ConfigStructureTableTableCreateCompanionBuilder =
    ConfigStructureTableCompanion Function({
      Value<int> id,
      required ConfigStructure content,
    });
typedef $$ConfigStructureTableTableUpdateCompanionBuilder =
    ConfigStructureTableCompanion Function({
      Value<int> id,
      Value<ConfigStructure> content,
    });

class $$ConfigStructureTableTableFilterComposer
    extends Composer<_$AppDatabase, $ConfigStructureTableTable> {
  $$ConfigStructureTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ConfigStructure, ConfigStructure, Uint8List>
  get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$ConfigStructureTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ConfigStructureTableTable> {
  $$ConfigStructureTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ConfigStructureTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConfigStructureTableTable> {
  $$ConfigStructureTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ConfigStructure, Uint8List> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);
}

class $$ConfigStructureTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ConfigStructureTableTable,
          ConfigStructureTableData,
          $$ConfigStructureTableTableFilterComposer,
          $$ConfigStructureTableTableOrderingComposer,
          $$ConfigStructureTableTableAnnotationComposer,
          $$ConfigStructureTableTableCreateCompanionBuilder,
          $$ConfigStructureTableTableUpdateCompanionBuilder,
          (
            ConfigStructureTableData,
            BaseReferences<
              _$AppDatabase,
              $ConfigStructureTableTable,
              ConfigStructureTableData
            >,
          ),
          ConfigStructureTableData,
          PrefetchHooks Function()
        > {
  $$ConfigStructureTableTableTableManager(
    _$AppDatabase db,
    $ConfigStructureTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ConfigStructureTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$ConfigStructureTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$ConfigStructureTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<ConfigStructure> content = const Value.absent(),
              }) => ConfigStructureTableCompanion(id: id, content: content),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required ConfigStructure content,
              }) => ConfigStructureTableCompanion.insert(
                id: id,
                content: content,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ConfigStructureTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ConfigStructureTableTable,
      ConfigStructureTableData,
      $$ConfigStructureTableTableFilterComposer,
      $$ConfigStructureTableTableOrderingComposer,
      $$ConfigStructureTableTableAnnotationComposer,
      $$ConfigStructureTableTableCreateCompanionBuilder,
      $$ConfigStructureTableTableUpdateCompanionBuilder,
      (
        ConfigStructureTableData,
        BaseReferences<
          _$AppDatabase,
          $ConfigStructureTableTable,
          ConfigStructureTableData
        >,
      ),
      ConfigStructureTableData,
      PrefetchHooks Function()
    >;
typedef $$StructureComponentTableTableCreateCompanionBuilder =
    StructureComponentTableCompanion Function({
      required String type,
      required String tagName,
      required String description,
      required String unit,
      required int digits,
      Value<String?> value,
      Value<String?> lastUpdateTime,
      Value<bool?> valid,
      Value<int> rowid,
    });
typedef $$StructureComponentTableTableUpdateCompanionBuilder =
    StructureComponentTableCompanion Function({
      Value<String> type,
      Value<String> tagName,
      Value<String> description,
      Value<String> unit,
      Value<int> digits,
      Value<String?> value,
      Value<String?> lastUpdateTime,
      Value<bool?> valid,
      Value<int> rowid,
    });

class $$StructureComponentTableTableFilterComposer
    extends Composer<_$AppDatabase, $StructureComponentTableTable> {
  $$StructureComponentTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tagName => $composableBuilder(
    column: $table.tagName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get digits => $composableBuilder(
    column: $table.digits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastUpdateTime => $composableBuilder(
    column: $table.lastUpdateTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get valid => $composableBuilder(
    column: $table.valid,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StructureComponentTableTableOrderingComposer
    extends Composer<_$AppDatabase, $StructureComponentTableTable> {
  $$StructureComponentTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tagName => $composableBuilder(
    column: $table.tagName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get digits => $composableBuilder(
    column: $table.digits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastUpdateTime => $composableBuilder(
    column: $table.lastUpdateTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get valid => $composableBuilder(
    column: $table.valid,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StructureComponentTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $StructureComponentTableTable> {
  $$StructureComponentTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get tagName =>
      $composableBuilder(column: $table.tagName, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<int> get digits =>
      $composableBuilder(column: $table.digits, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get lastUpdateTime => $composableBuilder(
    column: $table.lastUpdateTime,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get valid =>
      $composableBuilder(column: $table.valid, builder: (column) => column);
}

class $$StructureComponentTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StructureComponentTableTable,
          StructureComponentTableData,
          $$StructureComponentTableTableFilterComposer,
          $$StructureComponentTableTableOrderingComposer,
          $$StructureComponentTableTableAnnotationComposer,
          $$StructureComponentTableTableCreateCompanionBuilder,
          $$StructureComponentTableTableUpdateCompanionBuilder,
          (
            StructureComponentTableData,
            BaseReferences<
              _$AppDatabase,
              $StructureComponentTableTable,
              StructureComponentTableData
            >,
          ),
          StructureComponentTableData,
          PrefetchHooks Function()
        > {
  $$StructureComponentTableTableTableManager(
    _$AppDatabase db,
    $StructureComponentTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$StructureComponentTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$StructureComponentTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$StructureComponentTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> type = const Value.absent(),
                Value<String> tagName = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<int> digits = const Value.absent(),
                Value<String?> value = const Value.absent(),
                Value<String?> lastUpdateTime = const Value.absent(),
                Value<bool?> valid = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StructureComponentTableCompanion(
                type: type,
                tagName: tagName,
                description: description,
                unit: unit,
                digits: digits,
                value: value,
                lastUpdateTime: lastUpdateTime,
                valid: valid,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String type,
                required String tagName,
                required String description,
                required String unit,
                required int digits,
                Value<String?> value = const Value.absent(),
                Value<String?> lastUpdateTime = const Value.absent(),
                Value<bool?> valid = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StructureComponentTableCompanion.insert(
                type: type,
                tagName: tagName,
                description: description,
                unit: unit,
                digits: digits,
                value: value,
                lastUpdateTime: lastUpdateTime,
                valid: valid,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StructureComponentTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StructureComponentTableTable,
      StructureComponentTableData,
      $$StructureComponentTableTableFilterComposer,
      $$StructureComponentTableTableOrderingComposer,
      $$StructureComponentTableTableAnnotationComposer,
      $$StructureComponentTableTableCreateCompanionBuilder,
      $$StructureComponentTableTableUpdateCompanionBuilder,
      (
        StructureComponentTableData,
        BaseReferences<
          _$AppDatabase,
          $StructureComponentTableTable,
          StructureComponentTableData
        >,
      ),
      StructureComponentTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ConfigStructureTableTableTableManager get configStructureTable =>
      $$ConfigStructureTableTableTableManager(_db, _db.configStructureTable);
  $$StructureComponentTableTableTableManager get structureComponentTable =>
      $$StructureComponentTableTableTableManager(
        _db,
        _db.structureComponentTable,
      );
}
