// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// ignore_for_file: type=lint
class $ConfigStructureDBTable extends ConfigStructureDB
    with TableInfo<$ConfigStructureDBTable, ConfigStructureDBData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConfigStructureDBTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastUpdateMeta = const VerificationMeta(
    'lastUpdate',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdate = GeneratedColumn<DateTime>(
    'last_update',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, content, lastUpdate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'config_structure_d_b';
  @override
  VerificationContext validateIntegrity(
    Insertable<ConfigStructureDBData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('last_update')) {
      context.handle(
        _lastUpdateMeta,
        lastUpdate.isAcceptableOrUnknown(data['last_update']!, _lastUpdateMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ConfigStructureDBData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConfigStructureDBData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      content:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}content'],
          )!,
      lastUpdate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_update'],
      ),
    );
  }

  @override
  $ConfigStructureDBTable createAlias(String alias) {
    return $ConfigStructureDBTable(attachedDatabase, alias);
  }
}

class ConfigStructureDBData extends DataClass
    implements Insertable<ConfigStructureDBData> {
  final int id;
  final String content;
  final DateTime? lastUpdate;
  const ConfigStructureDBData({
    required this.id,
    required this.content,
    this.lastUpdate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || lastUpdate != null) {
      map['last_update'] = Variable<DateTime>(lastUpdate);
    }
    return map;
  }

  ConfigStructureDBCompanion toCompanion(bool nullToAbsent) {
    return ConfigStructureDBCompanion(
      id: Value(id),
      content: Value(content),
      lastUpdate:
          lastUpdate == null && nullToAbsent
              ? const Value.absent()
              : Value(lastUpdate),
    );
  }

  factory ConfigStructureDBData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConfigStructureDBData(
      id: serializer.fromJson<int>(json['id']),
      content: serializer.fromJson<String>(json['content']),
      lastUpdate: serializer.fromJson<DateTime?>(json['lastUpdate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'content': serializer.toJson<String>(content),
      'lastUpdate': serializer.toJson<DateTime?>(lastUpdate),
    };
  }

  ConfigStructureDBData copyWith({
    int? id,
    String? content,
    Value<DateTime?> lastUpdate = const Value.absent(),
  }) => ConfigStructureDBData(
    id: id ?? this.id,
    content: content ?? this.content,
    lastUpdate: lastUpdate.present ? lastUpdate.value : this.lastUpdate,
  );
  ConfigStructureDBData copyWithCompanion(ConfigStructureDBCompanion data) {
    return ConfigStructureDBData(
      id: data.id.present ? data.id.value : this.id,
      content: data.content.present ? data.content.value : this.content,
      lastUpdate:
          data.lastUpdate.present ? data.lastUpdate.value : this.lastUpdate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConfigStructureDBData(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('lastUpdate: $lastUpdate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, content, lastUpdate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConfigStructureDBData &&
          other.id == this.id &&
          other.content == this.content &&
          other.lastUpdate == this.lastUpdate);
}

class ConfigStructureDBCompanion
    extends UpdateCompanion<ConfigStructureDBData> {
  final Value<int> id;
  final Value<String> content;
  final Value<DateTime?> lastUpdate;
  const ConfigStructureDBCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    this.lastUpdate = const Value.absent(),
  });
  ConfigStructureDBCompanion.insert({
    this.id = const Value.absent(),
    required String content,
    this.lastUpdate = const Value.absent(),
  }) : content = Value(content);
  static Insertable<ConfigStructureDBData> custom({
    Expression<int>? id,
    Expression<String>? content,
    Expression<DateTime>? lastUpdate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
      if (lastUpdate != null) 'last_update': lastUpdate,
    });
  }

  ConfigStructureDBCompanion copyWith({
    Value<int>? id,
    Value<String>? content,
    Value<DateTime?>? lastUpdate,
  }) {
    return ConfigStructureDBCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (lastUpdate.present) {
      map['last_update'] = Variable<DateTime>(lastUpdate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConfigStructureDBCompanion(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('lastUpdate: $lastUpdate')
          ..write(')'))
        .toString();
  }
}

class $StructureComponentDBTable extends StructureComponentDB
    with TableInfo<$StructureComponentDBTable, StructureComponentDBData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StructureComponentDBTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tagNameMeta = const VerificationMeta(
    'tagName',
  );
  @override
  late final GeneratedColumn<String> tagName = GeneratedColumn<String>(
    'tag_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _digitsMeta = const VerificationMeta('digits');
  @override
  late final GeneratedColumn<int> digits = GeneratedColumn<int>(
    'digits',
    aliasedName,
    true,
    type: DriftSqlType.int,
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
    'is_valid',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_valid" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    tagName,
    value,
    description,
    unit,
    digits,
    lastUpdateTime,
    valid,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'structure_component_d_b';
  @override
  VerificationContext validateIntegrity(
    Insertable<StructureComponentDBData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    }
    if (data.containsKey('tag_name')) {
      context.handle(
        _tagNameMeta,
        tagName.isAcceptableOrUnknown(data['tag_name']!, _tagNameMeta),
      );
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('digits')) {
      context.handle(
        _digitsMeta,
        digits.isAcceptableOrUnknown(data['digits']!, _digitsMeta),
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
    if (data.containsKey('is_valid')) {
      context.handle(
        _validMeta,
        valid.isAcceptableOrUnknown(data['is_valid']!, _validMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StructureComponentDBData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StructureComponentDBData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      ),
      tagName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag_name'],
      ),
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      ),
      digits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}digits'],
      ),
      lastUpdateTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_update_time'],
      ),
      valid: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_valid'],
      ),
    );
  }

  @override
  $StructureComponentDBTable createAlias(String alias) {
    return $StructureComponentDBTable(attachedDatabase, alias);
  }
}

class StructureComponentDBData extends DataClass
    implements Insertable<StructureComponentDBData> {
  final int id;
  final String? type;
  final String? tagName;
  final String? value;
  final String? description;
  final String? unit;
  final int? digits;
  final String? lastUpdateTime;
  final bool? valid;
  const StructureComponentDBData({
    required this.id,
    this.type,
    this.tagName,
    this.value,
    this.description,
    this.unit,
    this.digits,
    this.lastUpdateTime,
    this.valid,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || tagName != null) {
      map['tag_name'] = Variable<String>(tagName);
    }
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<String>(value);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || unit != null) {
      map['unit'] = Variable<String>(unit);
    }
    if (!nullToAbsent || digits != null) {
      map['digits'] = Variable<int>(digits);
    }
    if (!nullToAbsent || lastUpdateTime != null) {
      map['last_update_time'] = Variable<String>(lastUpdateTime);
    }
    if (!nullToAbsent || valid != null) {
      map['is_valid'] = Variable<bool>(valid);
    }
    return map;
  }

  StructureComponentDBCompanion toCompanion(bool nullToAbsent) {
    return StructureComponentDBCompanion(
      id: Value(id),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      tagName:
          tagName == null && nullToAbsent
              ? const Value.absent()
              : Value(tagName),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
      description:
          description == null && nullToAbsent
              ? const Value.absent()
              : Value(description),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
      digits:
          digits == null && nullToAbsent ? const Value.absent() : Value(digits),
      lastUpdateTime:
          lastUpdateTime == null && nullToAbsent
              ? const Value.absent()
              : Value(lastUpdateTime),
      valid:
          valid == null && nullToAbsent ? const Value.absent() : Value(valid),
    );
  }

  factory StructureComponentDBData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StructureComponentDBData(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String?>(json['type']),
      tagName: serializer.fromJson<String?>(json['tagName']),
      value: serializer.fromJson<String?>(json['value']),
      description: serializer.fromJson<String?>(json['description']),
      unit: serializer.fromJson<String?>(json['unit']),
      digits: serializer.fromJson<int?>(json['digits']),
      lastUpdateTime: serializer.fromJson<String?>(json['lastUpdateTime']),
      valid: serializer.fromJson<bool?>(json['valid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String?>(type),
      'tagName': serializer.toJson<String?>(tagName),
      'value': serializer.toJson<String?>(value),
      'description': serializer.toJson<String?>(description),
      'unit': serializer.toJson<String?>(unit),
      'digits': serializer.toJson<int?>(digits),
      'lastUpdateTime': serializer.toJson<String?>(lastUpdateTime),
      'valid': serializer.toJson<bool?>(valid),
    };
  }

  StructureComponentDBData copyWith({
    int? id,
    Value<String?> type = const Value.absent(),
    Value<String?> tagName = const Value.absent(),
    Value<String?> value = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<String?> unit = const Value.absent(),
    Value<int?> digits = const Value.absent(),
    Value<String?> lastUpdateTime = const Value.absent(),
    Value<bool?> valid = const Value.absent(),
  }) => StructureComponentDBData(
    id: id ?? this.id,
    type: type.present ? type.value : this.type,
    tagName: tagName.present ? tagName.value : this.tagName,
    value: value.present ? value.value : this.value,
    description: description.present ? description.value : this.description,
    unit: unit.present ? unit.value : this.unit,
    digits: digits.present ? digits.value : this.digits,
    lastUpdateTime:
        lastUpdateTime.present ? lastUpdateTime.value : this.lastUpdateTime,
    valid: valid.present ? valid.value : this.valid,
  );
  StructureComponentDBData copyWithCompanion(
    StructureComponentDBCompanion data,
  ) {
    return StructureComponentDBData(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      tagName: data.tagName.present ? data.tagName.value : this.tagName,
      value: data.value.present ? data.value.value : this.value,
      description:
          data.description.present ? data.description.value : this.description,
      unit: data.unit.present ? data.unit.value : this.unit,
      digits: data.digits.present ? data.digits.value : this.digits,
      lastUpdateTime:
          data.lastUpdateTime.present
              ? data.lastUpdateTime.value
              : this.lastUpdateTime,
      valid: data.valid.present ? data.valid.value : this.valid,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StructureComponentDBData(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('tagName: $tagName, ')
          ..write('value: $value, ')
          ..write('description: $description, ')
          ..write('unit: $unit, ')
          ..write('digits: $digits, ')
          ..write('lastUpdateTime: $lastUpdateTime, ')
          ..write('valid: $valid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    tagName,
    value,
    description,
    unit,
    digits,
    lastUpdateTime,
    valid,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StructureComponentDBData &&
          other.id == this.id &&
          other.type == this.type &&
          other.tagName == this.tagName &&
          other.value == this.value &&
          other.description == this.description &&
          other.unit == this.unit &&
          other.digits == this.digits &&
          other.lastUpdateTime == this.lastUpdateTime &&
          other.valid == this.valid);
}

class StructureComponentDBCompanion
    extends UpdateCompanion<StructureComponentDBData> {
  final Value<int> id;
  final Value<String?> type;
  final Value<String?> tagName;
  final Value<String?> value;
  final Value<String?> description;
  final Value<String?> unit;
  final Value<int?> digits;
  final Value<String?> lastUpdateTime;
  final Value<bool?> valid;
  const StructureComponentDBCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.tagName = const Value.absent(),
    this.value = const Value.absent(),
    this.description = const Value.absent(),
    this.unit = const Value.absent(),
    this.digits = const Value.absent(),
    this.lastUpdateTime = const Value.absent(),
    this.valid = const Value.absent(),
  });
  StructureComponentDBCompanion.insert({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.tagName = const Value.absent(),
    this.value = const Value.absent(),
    this.description = const Value.absent(),
    this.unit = const Value.absent(),
    this.digits = const Value.absent(),
    this.lastUpdateTime = const Value.absent(),
    this.valid = const Value.absent(),
  });
  static Insertable<StructureComponentDBData> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<String>? tagName,
    Expression<String>? value,
    Expression<String>? description,
    Expression<String>? unit,
    Expression<int>? digits,
    Expression<String>? lastUpdateTime,
    Expression<bool>? valid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (tagName != null) 'tag_name': tagName,
      if (value != null) 'value': value,
      if (description != null) 'description': description,
      if (unit != null) 'unit': unit,
      if (digits != null) 'digits': digits,
      if (lastUpdateTime != null) 'last_update_time': lastUpdateTime,
      if (valid != null) 'is_valid': valid,
    });
  }

  StructureComponentDBCompanion copyWith({
    Value<int>? id,
    Value<String?>? type,
    Value<String?>? tagName,
    Value<String?>? value,
    Value<String?>? description,
    Value<String?>? unit,
    Value<int?>? digits,
    Value<String?>? lastUpdateTime,
    Value<bool?>? valid,
  }) {
    return StructureComponentDBCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      tagName: tagName ?? this.tagName,
      value: value ?? this.value,
      description: description ?? this.description,
      unit: unit ?? this.unit,
      digits: digits ?? this.digits,
      lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
      valid: valid ?? this.valid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (tagName.present) {
      map['tag_name'] = Variable<String>(tagName.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
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
    if (lastUpdateTime.present) {
      map['last_update_time'] = Variable<String>(lastUpdateTime.value);
    }
    if (valid.present) {
      map['is_valid'] = Variable<bool>(valid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StructureComponentDBCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('tagName: $tagName, ')
          ..write('value: $value, ')
          ..write('description: $description, ')
          ..write('unit: $unit, ')
          ..write('digits: $digits, ')
          ..write('lastUpdateTime: $lastUpdateTime, ')
          ..write('valid: $valid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ConfigStructureDBTable configStructureDB =
      $ConfigStructureDBTable(this);
  late final $StructureComponentDBTable structureComponentDB =
      $StructureComponentDBTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    configStructureDB,
    structureComponentDB,
  ];
}

typedef $$ConfigStructureDBTableCreateCompanionBuilder =
    ConfigStructureDBCompanion Function({
      Value<int> id,
      required String content,
      Value<DateTime?> lastUpdate,
    });
typedef $$ConfigStructureDBTableUpdateCompanionBuilder =
    ConfigStructureDBCompanion Function({
      Value<int> id,
      Value<String> content,
      Value<DateTime?> lastUpdate,
    });

class $$ConfigStructureDBTableFilterComposer
    extends Composer<_$AppDatabase, $ConfigStructureDBTable> {
  $$ConfigStructureDBTableFilterComposer({
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

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdate => $composableBuilder(
    column: $table.lastUpdate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ConfigStructureDBTableOrderingComposer
    extends Composer<_$AppDatabase, $ConfigStructureDBTable> {
  $$ConfigStructureDBTableOrderingComposer({
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

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdate => $composableBuilder(
    column: $table.lastUpdate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ConfigStructureDBTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConfigStructureDBTable> {
  $$ConfigStructureDBTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdate => $composableBuilder(
    column: $table.lastUpdate,
    builder: (column) => column,
  );
}

class $$ConfigStructureDBTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ConfigStructureDBTable,
          ConfigStructureDBData,
          $$ConfigStructureDBTableFilterComposer,
          $$ConfigStructureDBTableOrderingComposer,
          $$ConfigStructureDBTableAnnotationComposer,
          $$ConfigStructureDBTableCreateCompanionBuilder,
          $$ConfigStructureDBTableUpdateCompanionBuilder,
          (
            ConfigStructureDBData,
            BaseReferences<
              _$AppDatabase,
              $ConfigStructureDBTable,
              ConfigStructureDBData
            >,
          ),
          ConfigStructureDBData,
          PrefetchHooks Function()
        > {
  $$ConfigStructureDBTableTableManager(
    _$AppDatabase db,
    $ConfigStructureDBTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ConfigStructureDBTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$ConfigStructureDBTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$ConfigStructureDBTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<DateTime?> lastUpdate = const Value.absent(),
              }) => ConfigStructureDBCompanion(
                id: id,
                content: content,
                lastUpdate: lastUpdate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String content,
                Value<DateTime?> lastUpdate = const Value.absent(),
              }) => ConfigStructureDBCompanion.insert(
                id: id,
                content: content,
                lastUpdate: lastUpdate,
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

typedef $$ConfigStructureDBTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ConfigStructureDBTable,
      ConfigStructureDBData,
      $$ConfigStructureDBTableFilterComposer,
      $$ConfigStructureDBTableOrderingComposer,
      $$ConfigStructureDBTableAnnotationComposer,
      $$ConfigStructureDBTableCreateCompanionBuilder,
      $$ConfigStructureDBTableUpdateCompanionBuilder,
      (
        ConfigStructureDBData,
        BaseReferences<
          _$AppDatabase,
          $ConfigStructureDBTable,
          ConfigStructureDBData
        >,
      ),
      ConfigStructureDBData,
      PrefetchHooks Function()
    >;
typedef $$StructureComponentDBTableCreateCompanionBuilder =
    StructureComponentDBCompanion Function({
      Value<int> id,
      Value<String?> type,
      Value<String?> tagName,
      Value<String?> value,
      Value<String?> description,
      Value<String?> unit,
      Value<int?> digits,
      Value<String?> lastUpdateTime,
      Value<bool?> valid,
    });
typedef $$StructureComponentDBTableUpdateCompanionBuilder =
    StructureComponentDBCompanion Function({
      Value<int> id,
      Value<String?> type,
      Value<String?> tagName,
      Value<String?> value,
      Value<String?> description,
      Value<String?> unit,
      Value<int?> digits,
      Value<String?> lastUpdateTime,
      Value<bool?> valid,
    });

class $$StructureComponentDBTableFilterComposer
    extends Composer<_$AppDatabase, $StructureComponentDBTable> {
  $$StructureComponentDBTableFilterComposer({
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

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tagName => $composableBuilder(
    column: $table.tagName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
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

  ColumnFilters<String> get lastUpdateTime => $composableBuilder(
    column: $table.lastUpdateTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get valid => $composableBuilder(
    column: $table.valid,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StructureComponentDBTableOrderingComposer
    extends Composer<_$AppDatabase, $StructureComponentDBTable> {
  $$StructureComponentDBTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tagName => $composableBuilder(
    column: $table.tagName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
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

  ColumnOrderings<String> get lastUpdateTime => $composableBuilder(
    column: $table.lastUpdateTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get valid => $composableBuilder(
    column: $table.valid,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StructureComponentDBTableAnnotationComposer
    extends Composer<_$AppDatabase, $StructureComponentDBTable> {
  $$StructureComponentDBTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get tagName =>
      $composableBuilder(column: $table.tagName, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<int> get digits =>
      $composableBuilder(column: $table.digits, builder: (column) => column);

  GeneratedColumn<String> get lastUpdateTime => $composableBuilder(
    column: $table.lastUpdateTime,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get valid =>
      $composableBuilder(column: $table.valid, builder: (column) => column);
}

class $$StructureComponentDBTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StructureComponentDBTable,
          StructureComponentDBData,
          $$StructureComponentDBTableFilterComposer,
          $$StructureComponentDBTableOrderingComposer,
          $$StructureComponentDBTableAnnotationComposer,
          $$StructureComponentDBTableCreateCompanionBuilder,
          $$StructureComponentDBTableUpdateCompanionBuilder,
          (
            StructureComponentDBData,
            BaseReferences<
              _$AppDatabase,
              $StructureComponentDBTable,
              StructureComponentDBData
            >,
          ),
          StructureComponentDBData,
          PrefetchHooks Function()
        > {
  $$StructureComponentDBTableTableManager(
    _$AppDatabase db,
    $StructureComponentDBTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$StructureComponentDBTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$StructureComponentDBTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$StructureComponentDBTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> type = const Value.absent(),
                Value<String?> tagName = const Value.absent(),
                Value<String?> value = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> unit = const Value.absent(),
                Value<int?> digits = const Value.absent(),
                Value<String?> lastUpdateTime = const Value.absent(),
                Value<bool?> valid = const Value.absent(),
              }) => StructureComponentDBCompanion(
                id: id,
                type: type,
                tagName: tagName,
                value: value,
                description: description,
                unit: unit,
                digits: digits,
                lastUpdateTime: lastUpdateTime,
                valid: valid,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> type = const Value.absent(),
                Value<String?> tagName = const Value.absent(),
                Value<String?> value = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> unit = const Value.absent(),
                Value<int?> digits = const Value.absent(),
                Value<String?> lastUpdateTime = const Value.absent(),
                Value<bool?> valid = const Value.absent(),
              }) => StructureComponentDBCompanion.insert(
                id: id,
                type: type,
                tagName: tagName,
                value: value,
                description: description,
                unit: unit,
                digits: digits,
                lastUpdateTime: lastUpdateTime,
                valid: valid,
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

typedef $$StructureComponentDBTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StructureComponentDBTable,
      StructureComponentDBData,
      $$StructureComponentDBTableFilterComposer,
      $$StructureComponentDBTableOrderingComposer,
      $$StructureComponentDBTableAnnotationComposer,
      $$StructureComponentDBTableCreateCompanionBuilder,
      $$StructureComponentDBTableUpdateCompanionBuilder,
      (
        StructureComponentDBData,
        BaseReferences<
          _$AppDatabase,
          $StructureComponentDBTable,
          StructureComponentDBData
        >,
      ),
      StructureComponentDBData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ConfigStructureDBTableTableManager get configStructureDB =>
      $$ConfigStructureDBTableTableManager(_db, _db.configStructureDB);
  $$StructureComponentDBTableTableManager get structureComponentDB =>
      $$StructureComponentDBTableTableManager(_db, _db.structureComponentDB);
}
