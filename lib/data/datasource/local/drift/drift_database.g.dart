// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $CategoryTableTable extends CategoryTable
    with TableInfo<$CategoryTableTable, CategoryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, title, createdAt];
  @override
  String get aliasedName => _alias ?? 'category_table';
  @override
  String get actualTableName => 'category_table';
  @override
  VerificationContext validateIntegrity(Insertable<CategoryTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $CategoryTableTable createAlias(String alias) {
    return $CategoryTableTable(attachedDatabase, alias);
  }
}

class CategoryTableData extends DataClass
    implements Insertable<CategoryTableData> {
  final int id;
  final String title;
  final DateTime createdAt;
  const CategoryTableData(
      {required this.id, required this.title, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CategoryTableCompanion toCompanion(bool nullToAbsent) {
    return CategoryTableCompanion(
      id: Value(id),
      title: Value(title),
      createdAt: Value(createdAt),
    );
  }

  factory CategoryTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryTableData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CategoryTableData copyWith({int? id, String? title, DateTime? createdAt}) =>
      CategoryTableData(
        id: id ?? this.id,
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('CategoryTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.createdAt == this.createdAt);
}

class CategoryTableCompanion extends UpdateCompanion<CategoryTableData> {
  final Value<int> id;
  final Value<String> title;
  final Value<DateTime> createdAt;
  const CategoryTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CategoryTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.createdAt = const Value.absent(),
  }) : title = Value(title);
  static Insertable<CategoryTableData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CategoryTableCompanion copyWith(
      {Value<int>? id, Value<String>? title, Value<DateTime>? createdAt}) {
    return CategoryTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ProductTableTable extends ProductTable
    with TableInfo<$ProductTableTable, ProductTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeProductMeta =
      const VerificationMeta('codeProduct');
  @override
  late final GeneratedColumn<String> codeProduct = GeneratedColumn<String>(
      'code_product', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 14),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 24),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _capitalPriceMeta =
      const VerificationMeta('capitalPrice');
  @override
  late final GeneratedColumn<int> capitalPrice = GeneratedColumn<int>(
      'capital_price', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _sellPriceMeta =
      const VerificationMeta('sellPrice');
  @override
  late final GeneratedColumn<int> sellPrice = GeneratedColumn<int>(
      'sell_price', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _stockMeta = const VerificationMeta('stock');
  @override
  late final GeneratedColumn<int> stock = GeneratedColumn<int>(
      'stock', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _soldMeta = const VerificationMeta('sold');
  @override
  late final GeneratedColumn<int> sold = GeneratedColumn<int>(
      'sold', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES category_table (id)'));
  @override
  List<GeneratedColumn> get $columns => [
        codeProduct,
        name,
        capitalPrice,
        sellPrice,
        stock,
        sold,
        createdAt,
        updatedAt,
        categoryId
      ];
  @override
  String get aliasedName => _alias ?? 'product_table';
  @override
  String get actualTableName => 'product_table';
  @override
  VerificationContext validateIntegrity(Insertable<ProductTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code_product')) {
      context.handle(
          _codeProductMeta,
          codeProduct.isAcceptableOrUnknown(
              data['code_product']!, _codeProductMeta));
    } else if (isInserting) {
      context.missing(_codeProductMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('capital_price')) {
      context.handle(
          _capitalPriceMeta,
          capitalPrice.isAcceptableOrUnknown(
              data['capital_price']!, _capitalPriceMeta));
    } else if (isInserting) {
      context.missing(_capitalPriceMeta);
    }
    if (data.containsKey('sell_price')) {
      context.handle(_sellPriceMeta,
          sellPrice.isAcceptableOrUnknown(data['sell_price']!, _sellPriceMeta));
    } else if (isInserting) {
      context.missing(_sellPriceMeta);
    }
    if (data.containsKey('stock')) {
      context.handle(
          _stockMeta, stock.isAcceptableOrUnknown(data['stock']!, _stockMeta));
    } else if (isInserting) {
      context.missing(_stockMeta);
    }
    if (data.containsKey('sold')) {
      context.handle(
          _soldMeta, sold.isAcceptableOrUnknown(data['sold']!, _soldMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {codeProduct};
  @override
  ProductTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductTableData(
      codeProduct: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code_product'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      capitalPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}capital_price'])!,
      sellPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sell_price'])!,
      stock: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stock'])!,
      sold: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sold'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id'])!,
    );
  }

  @override
  $ProductTableTable createAlias(String alias) {
    return $ProductTableTable(attachedDatabase, alias);
  }
}

class ProductTableData extends DataClass
    implements Insertable<ProductTableData> {
  final String codeProduct;
  final String name;
  final int capitalPrice;
  final int sellPrice;
  final int stock;
  final int sold;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int categoryId;
  const ProductTableData(
      {required this.codeProduct,
      required this.name,
      required this.capitalPrice,
      required this.sellPrice,
      required this.stock,
      required this.sold,
      required this.createdAt,
      this.updatedAt,
      required this.categoryId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code_product'] = Variable<String>(codeProduct);
    map['name'] = Variable<String>(name);
    map['capital_price'] = Variable<int>(capitalPrice);
    map['sell_price'] = Variable<int>(sellPrice);
    map['stock'] = Variable<int>(stock);
    map['sold'] = Variable<int>(sold);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    map['category_id'] = Variable<int>(categoryId);
    return map;
  }

  ProductTableCompanion toCompanion(bool nullToAbsent) {
    return ProductTableCompanion(
      codeProduct: Value(codeProduct),
      name: Value(name),
      capitalPrice: Value(capitalPrice),
      sellPrice: Value(sellPrice),
      stock: Value(stock),
      sold: Value(sold),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      categoryId: Value(categoryId),
    );
  }

  factory ProductTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductTableData(
      codeProduct: serializer.fromJson<String>(json['codeProduct']),
      name: serializer.fromJson<String>(json['name']),
      capitalPrice: serializer.fromJson<int>(json['capitalPrice']),
      sellPrice: serializer.fromJson<int>(json['sellPrice']),
      stock: serializer.fromJson<int>(json['stock']),
      sold: serializer.fromJson<int>(json['sold']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'codeProduct': serializer.toJson<String>(codeProduct),
      'name': serializer.toJson<String>(name),
      'capitalPrice': serializer.toJson<int>(capitalPrice),
      'sellPrice': serializer.toJson<int>(sellPrice),
      'stock': serializer.toJson<int>(stock),
      'sold': serializer.toJson<int>(sold),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'categoryId': serializer.toJson<int>(categoryId),
    };
  }

  ProductTableData copyWith(
          {String? codeProduct,
          String? name,
          int? capitalPrice,
          int? sellPrice,
          int? stock,
          int? sold,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent(),
          int? categoryId}) =>
      ProductTableData(
        codeProduct: codeProduct ?? this.codeProduct,
        name: name ?? this.name,
        capitalPrice: capitalPrice ?? this.capitalPrice,
        sellPrice: sellPrice ?? this.sellPrice,
        stock: stock ?? this.stock,
        sold: sold ?? this.sold,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        categoryId: categoryId ?? this.categoryId,
      );
  @override
  String toString() {
    return (StringBuffer('ProductTableData(')
          ..write('codeProduct: $codeProduct, ')
          ..write('name: $name, ')
          ..write('capitalPrice: $capitalPrice, ')
          ..write('sellPrice: $sellPrice, ')
          ..write('stock: $stock, ')
          ..write('sold: $sold, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('categoryId: $categoryId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(codeProduct, name, capitalPrice, sellPrice,
      stock, sold, createdAt, updatedAt, categoryId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductTableData &&
          other.codeProduct == this.codeProduct &&
          other.name == this.name &&
          other.capitalPrice == this.capitalPrice &&
          other.sellPrice == this.sellPrice &&
          other.stock == this.stock &&
          other.sold == this.sold &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.categoryId == this.categoryId);
}

class ProductTableCompanion extends UpdateCompanion<ProductTableData> {
  final Value<String> codeProduct;
  final Value<String> name;
  final Value<int> capitalPrice;
  final Value<int> sellPrice;
  final Value<int> stock;
  final Value<int> sold;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> categoryId;
  final Value<int> rowid;
  const ProductTableCompanion({
    this.codeProduct = const Value.absent(),
    this.name = const Value.absent(),
    this.capitalPrice = const Value.absent(),
    this.sellPrice = const Value.absent(),
    this.stock = const Value.absent(),
    this.sold = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductTableCompanion.insert({
    required String codeProduct,
    required String name,
    required int capitalPrice,
    required int sellPrice,
    required int stock,
    this.sold = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required int categoryId,
    this.rowid = const Value.absent(),
  })  : codeProduct = Value(codeProduct),
        name = Value(name),
        capitalPrice = Value(capitalPrice),
        sellPrice = Value(sellPrice),
        stock = Value(stock),
        categoryId = Value(categoryId);
  static Insertable<ProductTableData> custom({
    Expression<String>? codeProduct,
    Expression<String>? name,
    Expression<int>? capitalPrice,
    Expression<int>? sellPrice,
    Expression<int>? stock,
    Expression<int>? sold,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? categoryId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (codeProduct != null) 'code_product': codeProduct,
      if (name != null) 'name': name,
      if (capitalPrice != null) 'capital_price': capitalPrice,
      if (sellPrice != null) 'sell_price': sellPrice,
      if (stock != null) 'stock': stock,
      if (sold != null) 'sold': sold,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (categoryId != null) 'category_id': categoryId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductTableCompanion copyWith(
      {Value<String>? codeProduct,
      Value<String>? name,
      Value<int>? capitalPrice,
      Value<int>? sellPrice,
      Value<int>? stock,
      Value<int>? sold,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? categoryId,
      Value<int>? rowid}) {
    return ProductTableCompanion(
      codeProduct: codeProduct ?? this.codeProduct,
      name: name ?? this.name,
      capitalPrice: capitalPrice ?? this.capitalPrice,
      sellPrice: sellPrice ?? this.sellPrice,
      stock: stock ?? this.stock,
      sold: sold ?? this.sold,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      categoryId: categoryId ?? this.categoryId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (codeProduct.present) {
      map['code_product'] = Variable<String>(codeProduct.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (capitalPrice.present) {
      map['capital_price'] = Variable<int>(capitalPrice.value);
    }
    if (sellPrice.present) {
      map['sell_price'] = Variable<int>(sellPrice.value);
    }
    if (stock.present) {
      map['stock'] = Variable<int>(stock.value);
    }
    if (sold.present) {
      map['sold'] = Variable<int>(sold.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductTableCompanion(')
          ..write('codeProduct: $codeProduct, ')
          ..write('name: $name, ')
          ..write('capitalPrice: $capitalPrice, ')
          ..write('sellPrice: $sellPrice, ')
          ..write('stock: $stock, ')
          ..write('sold: $sold, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('categoryId: $categoryId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CounterTransactionTableTable extends CounterTransactionTable
    with TableInfo<$CounterTransactionTableTable, CounterTransactionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CounterTransactionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _totalTransactionMeta =
      const VerificationMeta('totalTransaction');
  @override
  late final GeneratedColumn<int> totalTransaction = GeneratedColumn<int>(
      'total_transaction', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, totalTransaction, date];
  @override
  String get aliasedName => _alias ?? 'counter_transaction_table';
  @override
  String get actualTableName => 'counter_transaction_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<CounterTransactionTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('total_transaction')) {
      context.handle(
          _totalTransactionMeta,
          totalTransaction.isAcceptableOrUnknown(
              data['total_transaction']!, _totalTransactionMeta));
    } else if (isInserting) {
      context.missing(_totalTransactionMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CounterTransactionTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CounterTransactionTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      totalTransaction: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_transaction'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
    );
  }

  @override
  $CounterTransactionTableTable createAlias(String alias) {
    return $CounterTransactionTableTable(attachedDatabase, alias);
  }
}

class CounterTransactionTableData extends DataClass
    implements Insertable<CounterTransactionTableData> {
  final int id;
  final int totalTransaction;
  final DateTime date;
  const CounterTransactionTableData(
      {required this.id, required this.totalTransaction, required this.date});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['total_transaction'] = Variable<int>(totalTransaction);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  CounterTransactionTableCompanion toCompanion(bool nullToAbsent) {
    return CounterTransactionTableCompanion(
      id: Value(id),
      totalTransaction: Value(totalTransaction),
      date: Value(date),
    );
  }

  factory CounterTransactionTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CounterTransactionTableData(
      id: serializer.fromJson<int>(json['id']),
      totalTransaction: serializer.fromJson<int>(json['totalTransaction']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'totalTransaction': serializer.toJson<int>(totalTransaction),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  CounterTransactionTableData copyWith(
          {int? id, int? totalTransaction, DateTime? date}) =>
      CounterTransactionTableData(
        id: id ?? this.id,
        totalTransaction: totalTransaction ?? this.totalTransaction,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('CounterTransactionTableData(')
          ..write('id: $id, ')
          ..write('totalTransaction: $totalTransaction, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, totalTransaction, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CounterTransactionTableData &&
          other.id == this.id &&
          other.totalTransaction == this.totalTransaction &&
          other.date == this.date);
}

class CounterTransactionTableCompanion
    extends UpdateCompanion<CounterTransactionTableData> {
  final Value<int> id;
  final Value<int> totalTransaction;
  final Value<DateTime> date;
  const CounterTransactionTableCompanion({
    this.id = const Value.absent(),
    this.totalTransaction = const Value.absent(),
    this.date = const Value.absent(),
  });
  CounterTransactionTableCompanion.insert({
    this.id = const Value.absent(),
    required int totalTransaction,
    required DateTime date,
  })  : totalTransaction = Value(totalTransaction),
        date = Value(date);
  static Insertable<CounterTransactionTableData> custom({
    Expression<int>? id,
    Expression<int>? totalTransaction,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (totalTransaction != null) 'total_transaction': totalTransaction,
      if (date != null) 'date': date,
    });
  }

  CounterTransactionTableCompanion copyWith(
      {Value<int>? id, Value<int>? totalTransaction, Value<DateTime>? date}) {
    return CounterTransactionTableCompanion(
      id: id ?? this.id,
      totalTransaction: totalTransaction ?? this.totalTransaction,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (totalTransaction.present) {
      map['total_transaction'] = Variable<int>(totalTransaction.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CounterTransactionTableCompanion(')
          ..write('id: $id, ')
          ..write('totalTransaction: $totalTransaction, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $TransactionTableTable extends TransactionTable
    with TableInfo<$TransactionTableTable, TransactionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _noMeta = const VerificationMeta('no');
  @override
  late final GeneratedColumn<String> no = GeneratedColumn<String>(
      'no', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _totalPayMeta =
      const VerificationMeta('totalPay');
  @override
  late final GeneratedColumn<int> totalPay = GeneratedColumn<int>(
      'total_pay', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dateTransactionMeta =
      const VerificationMeta('dateTransaction');
  @override
  late final GeneratedColumn<DateTime> dateTransaction =
      GeneratedColumn<DateTime>('date_transaction', aliasedName, false,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, no, totalPay, dateTransaction];
  @override
  String get aliasedName => _alias ?? 'transaction_table';
  @override
  String get actualTableName => 'transaction_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<TransactionTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('no')) {
      context.handle(_noMeta, no.isAcceptableOrUnknown(data['no']!, _noMeta));
    } else if (isInserting) {
      context.missing(_noMeta);
    }
    if (data.containsKey('total_pay')) {
      context.handle(_totalPayMeta,
          totalPay.isAcceptableOrUnknown(data['total_pay']!, _totalPayMeta));
    } else if (isInserting) {
      context.missing(_totalPayMeta);
    }
    if (data.containsKey('date_transaction')) {
      context.handle(
          _dateTransactionMeta,
          dateTransaction.isAcceptableOrUnknown(
              data['date_transaction']!, _dateTransactionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      no: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}no'])!,
      totalPay: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_pay'])!,
      dateTransaction: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}date_transaction'])!,
    );
  }

  @override
  $TransactionTableTable createAlias(String alias) {
    return $TransactionTableTable(attachedDatabase, alias);
  }
}

class TransactionTableData extends DataClass
    implements Insertable<TransactionTableData> {
  final int id;
  final String no;
  final int totalPay;
  final DateTime dateTransaction;
  const TransactionTableData(
      {required this.id,
      required this.no,
      required this.totalPay,
      required this.dateTransaction});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['no'] = Variable<String>(no);
    map['total_pay'] = Variable<int>(totalPay);
    map['date_transaction'] = Variable<DateTime>(dateTransaction);
    return map;
  }

  TransactionTableCompanion toCompanion(bool nullToAbsent) {
    return TransactionTableCompanion(
      id: Value(id),
      no: Value(no),
      totalPay: Value(totalPay),
      dateTransaction: Value(dateTransaction),
    );
  }

  factory TransactionTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionTableData(
      id: serializer.fromJson<int>(json['id']),
      no: serializer.fromJson<String>(json['no']),
      totalPay: serializer.fromJson<int>(json['totalPay']),
      dateTransaction: serializer.fromJson<DateTime>(json['dateTransaction']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'no': serializer.toJson<String>(no),
      'totalPay': serializer.toJson<int>(totalPay),
      'dateTransaction': serializer.toJson<DateTime>(dateTransaction),
    };
  }

  TransactionTableData copyWith(
          {int? id, String? no, int? totalPay, DateTime? dateTransaction}) =>
      TransactionTableData(
        id: id ?? this.id,
        no: no ?? this.no,
        totalPay: totalPay ?? this.totalPay,
        dateTransaction: dateTransaction ?? this.dateTransaction,
      );
  @override
  String toString() {
    return (StringBuffer('TransactionTableData(')
          ..write('id: $id, ')
          ..write('no: $no, ')
          ..write('totalPay: $totalPay, ')
          ..write('dateTransaction: $dateTransaction')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, no, totalPay, dateTransaction);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionTableData &&
          other.id == this.id &&
          other.no == this.no &&
          other.totalPay == this.totalPay &&
          other.dateTransaction == this.dateTransaction);
}

class TransactionTableCompanion extends UpdateCompanion<TransactionTableData> {
  final Value<int> id;
  final Value<String> no;
  final Value<int> totalPay;
  final Value<DateTime> dateTransaction;
  const TransactionTableCompanion({
    this.id = const Value.absent(),
    this.no = const Value.absent(),
    this.totalPay = const Value.absent(),
    this.dateTransaction = const Value.absent(),
  });
  TransactionTableCompanion.insert({
    this.id = const Value.absent(),
    required String no,
    required int totalPay,
    this.dateTransaction = const Value.absent(),
  })  : no = Value(no),
        totalPay = Value(totalPay);
  static Insertable<TransactionTableData> custom({
    Expression<int>? id,
    Expression<String>? no,
    Expression<int>? totalPay,
    Expression<DateTime>? dateTransaction,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (no != null) 'no': no,
      if (totalPay != null) 'total_pay': totalPay,
      if (dateTransaction != null) 'date_transaction': dateTransaction,
    });
  }

  TransactionTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? no,
      Value<int>? totalPay,
      Value<DateTime>? dateTransaction}) {
    return TransactionTableCompanion(
      id: id ?? this.id,
      no: no ?? this.no,
      totalPay: totalPay ?? this.totalPay,
      dateTransaction: dateTransaction ?? this.dateTransaction,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (no.present) {
      map['no'] = Variable<String>(no.value);
    }
    if (totalPay.present) {
      map['total_pay'] = Variable<int>(totalPay.value);
    }
    if (dateTransaction.present) {
      map['date_transaction'] = Variable<DateTime>(dateTransaction.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionTableCompanion(')
          ..write('id: $id, ')
          ..write('no: $no, ')
          ..write('totalPay: $totalPay, ')
          ..write('dateTransaction: $dateTransaction')
          ..write(')'))
        .toString();
  }
}

class $DetailTransactionTableTable extends DetailTransactionTable
    with TableInfo<$DetailTransactionTableTable, DetailTransactionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DetailTransactionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _qtyMeta = const VerificationMeta('qty');
  @override
  late final GeneratedColumn<int> qty = GeneratedColumn<int>(
      'qty', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<int> total = GeneratedColumn<int>(
      'total', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _codeProductMeta =
      const VerificationMeta('codeProduct');
  @override
  late final GeneratedColumn<String> codeProduct = GeneratedColumn<String>(
      'code_product', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES product_table (code_product)'));
  static const VerificationMeta _idTransactionMeta =
      const VerificationMeta('idTransaction');
  @override
  late final GeneratedColumn<int> idTransaction = GeneratedColumn<int>(
      'id_transaction', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES transaction_table (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, qty, total, codeProduct, idTransaction];
  @override
  String get aliasedName => _alias ?? 'detail_transaction_table';
  @override
  String get actualTableName => 'detail_transaction_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<DetailTransactionTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('qty')) {
      context.handle(
          _qtyMeta, qty.isAcceptableOrUnknown(data['qty']!, _qtyMeta));
    } else if (isInserting) {
      context.missing(_qtyMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
          _totalMeta, total.isAcceptableOrUnknown(data['total']!, _totalMeta));
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('code_product')) {
      context.handle(
          _codeProductMeta,
          codeProduct.isAcceptableOrUnknown(
              data['code_product']!, _codeProductMeta));
    } else if (isInserting) {
      context.missing(_codeProductMeta);
    }
    if (data.containsKey('id_transaction')) {
      context.handle(
          _idTransactionMeta,
          idTransaction.isAcceptableOrUnknown(
              data['id_transaction']!, _idTransactionMeta));
    } else if (isInserting) {
      context.missing(_idTransactionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DetailTransactionTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DetailTransactionTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      qty: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}qty'])!,
      total: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total'])!,
      codeProduct: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code_product'])!,
      idTransaction: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_transaction'])!,
    );
  }

  @override
  $DetailTransactionTableTable createAlias(String alias) {
    return $DetailTransactionTableTable(attachedDatabase, alias);
  }
}

class DetailTransactionTableData extends DataClass
    implements Insertable<DetailTransactionTableData> {
  final int id;
  final int qty;
  final int total;
  final String codeProduct;
  final int idTransaction;
  const DetailTransactionTableData(
      {required this.id,
      required this.qty,
      required this.total,
      required this.codeProduct,
      required this.idTransaction});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['qty'] = Variable<int>(qty);
    map['total'] = Variable<int>(total);
    map['code_product'] = Variable<String>(codeProduct);
    map['id_transaction'] = Variable<int>(idTransaction);
    return map;
  }

  DetailTransactionTableCompanion toCompanion(bool nullToAbsent) {
    return DetailTransactionTableCompanion(
      id: Value(id),
      qty: Value(qty),
      total: Value(total),
      codeProduct: Value(codeProduct),
      idTransaction: Value(idTransaction),
    );
  }

  factory DetailTransactionTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DetailTransactionTableData(
      id: serializer.fromJson<int>(json['id']),
      qty: serializer.fromJson<int>(json['qty']),
      total: serializer.fromJson<int>(json['total']),
      codeProduct: serializer.fromJson<String>(json['codeProduct']),
      idTransaction: serializer.fromJson<int>(json['idTransaction']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'qty': serializer.toJson<int>(qty),
      'total': serializer.toJson<int>(total),
      'codeProduct': serializer.toJson<String>(codeProduct),
      'idTransaction': serializer.toJson<int>(idTransaction),
    };
  }

  DetailTransactionTableData copyWith(
          {int? id,
          int? qty,
          int? total,
          String? codeProduct,
          int? idTransaction}) =>
      DetailTransactionTableData(
        id: id ?? this.id,
        qty: qty ?? this.qty,
        total: total ?? this.total,
        codeProduct: codeProduct ?? this.codeProduct,
        idTransaction: idTransaction ?? this.idTransaction,
      );
  @override
  String toString() {
    return (StringBuffer('DetailTransactionTableData(')
          ..write('id: $id, ')
          ..write('qty: $qty, ')
          ..write('total: $total, ')
          ..write('codeProduct: $codeProduct, ')
          ..write('idTransaction: $idTransaction')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, qty, total, codeProduct, idTransaction);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DetailTransactionTableData &&
          other.id == this.id &&
          other.qty == this.qty &&
          other.total == this.total &&
          other.codeProduct == this.codeProduct &&
          other.idTransaction == this.idTransaction);
}

class DetailTransactionTableCompanion
    extends UpdateCompanion<DetailTransactionTableData> {
  final Value<int> id;
  final Value<int> qty;
  final Value<int> total;
  final Value<String> codeProduct;
  final Value<int> idTransaction;
  const DetailTransactionTableCompanion({
    this.id = const Value.absent(),
    this.qty = const Value.absent(),
    this.total = const Value.absent(),
    this.codeProduct = const Value.absent(),
    this.idTransaction = const Value.absent(),
  });
  DetailTransactionTableCompanion.insert({
    this.id = const Value.absent(),
    required int qty,
    required int total,
    required String codeProduct,
    required int idTransaction,
  })  : qty = Value(qty),
        total = Value(total),
        codeProduct = Value(codeProduct),
        idTransaction = Value(idTransaction);
  static Insertable<DetailTransactionTableData> custom({
    Expression<int>? id,
    Expression<int>? qty,
    Expression<int>? total,
    Expression<String>? codeProduct,
    Expression<int>? idTransaction,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (qty != null) 'qty': qty,
      if (total != null) 'total': total,
      if (codeProduct != null) 'code_product': codeProduct,
      if (idTransaction != null) 'id_transaction': idTransaction,
    });
  }

  DetailTransactionTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? qty,
      Value<int>? total,
      Value<String>? codeProduct,
      Value<int>? idTransaction}) {
    return DetailTransactionTableCompanion(
      id: id ?? this.id,
      qty: qty ?? this.qty,
      total: total ?? this.total,
      codeProduct: codeProduct ?? this.codeProduct,
      idTransaction: idTransaction ?? this.idTransaction,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (qty.present) {
      map['qty'] = Variable<int>(qty.value);
    }
    if (total.present) {
      map['total'] = Variable<int>(total.value);
    }
    if (codeProduct.present) {
      map['code_product'] = Variable<String>(codeProduct.value);
    }
    if (idTransaction.present) {
      map['id_transaction'] = Variable<int>(idTransaction.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DetailTransactionTableCompanion(')
          ..write('id: $id, ')
          ..write('qty: $qty, ')
          ..write('total: $total, ')
          ..write('codeProduct: $codeProduct, ')
          ..write('idTransaction: $idTransaction')
          ..write(')'))
        .toString();
  }
}

class ProductViewData extends DataClass {
  final String codeProduct;
  final String name;
  final int capitalPrice;
  final int sellPrice;
  final int stock;
  final int sold;
  final String title;
  const ProductViewData(
      {required this.codeProduct,
      required this.name,
      required this.capitalPrice,
      required this.sellPrice,
      required this.stock,
      required this.sold,
      required this.title});
  factory ProductViewData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductViewData(
      codeProduct: serializer.fromJson<String>(json['codeProduct']),
      name: serializer.fromJson<String>(json['name']),
      capitalPrice: serializer.fromJson<int>(json['capitalPrice']),
      sellPrice: serializer.fromJson<int>(json['sellPrice']),
      stock: serializer.fromJson<int>(json['stock']),
      sold: serializer.fromJson<int>(json['sold']),
      title: serializer.fromJson<String>(json['title']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'codeProduct': serializer.toJson<String>(codeProduct),
      'name': serializer.toJson<String>(name),
      'capitalPrice': serializer.toJson<int>(capitalPrice),
      'sellPrice': serializer.toJson<int>(sellPrice),
      'stock': serializer.toJson<int>(stock),
      'sold': serializer.toJson<int>(sold),
      'title': serializer.toJson<String>(title),
    };
  }

  ProductViewData copyWith(
          {String? codeProduct,
          String? name,
          int? capitalPrice,
          int? sellPrice,
          int? stock,
          int? sold,
          String? title}) =>
      ProductViewData(
        codeProduct: codeProduct ?? this.codeProduct,
        name: name ?? this.name,
        capitalPrice: capitalPrice ?? this.capitalPrice,
        sellPrice: sellPrice ?? this.sellPrice,
        stock: stock ?? this.stock,
        sold: sold ?? this.sold,
        title: title ?? this.title,
      );
  @override
  String toString() {
    return (StringBuffer('ProductViewData(')
          ..write('codeProduct: $codeProduct, ')
          ..write('name: $name, ')
          ..write('capitalPrice: $capitalPrice, ')
          ..write('sellPrice: $sellPrice, ')
          ..write('stock: $stock, ')
          ..write('sold: $sold, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      codeProduct, name, capitalPrice, sellPrice, stock, sold, title);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductViewData &&
          other.codeProduct == this.codeProduct &&
          other.name == this.name &&
          other.capitalPrice == this.capitalPrice &&
          other.sellPrice == this.sellPrice &&
          other.stock == this.stock &&
          other.sold == this.sold &&
          other.title == this.title);
}

class $ProductViewView extends ViewInfo<$ProductViewView, ProductViewData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$DatabaseApp attachedDatabase;
  $ProductViewView(this.attachedDatabase, [this._alias]);
  $CategoryTableTable get categoryTable =>
      attachedDatabase.categoryTable.createAlias('t0');
  $ProductTableTable get productTable =>
      attachedDatabase.productTable.createAlias('t1');
  @override
  List<GeneratedColumn> get $columns =>
      [codeProduct, name, capitalPrice, sellPrice, stock, sold, title];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'product_view';
  @override
  String? get createViewStmt => null;
  @override
  $ProductViewView get asDslTable => this;
  @override
  ProductViewData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductViewData(
      codeProduct: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code_product'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      capitalPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}capital_price'])!,
      sellPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sell_price'])!,
      stock: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stock'])!,
      sold: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sold'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
    );
  }

  late final GeneratedColumn<String> codeProduct = GeneratedColumn<String>(
      'code_product', aliasedName, false,
      generatedAs: GeneratedAs(productTable.codeProduct, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      generatedAs: GeneratedAs(productTable.name, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<int> capitalPrice = GeneratedColumn<int>(
      'capital_price', aliasedName, false,
      generatedAs: GeneratedAs(productTable.capitalPrice, false),
      type: DriftSqlType.int);
  late final GeneratedColumn<int> sellPrice = GeneratedColumn<int>(
      'sell_price', aliasedName, false,
      generatedAs: GeneratedAs(productTable.sellPrice, false),
      type: DriftSqlType.int);
  late final GeneratedColumn<int> stock = GeneratedColumn<int>(
      'stock', aliasedName, false,
      generatedAs: GeneratedAs(productTable.stock, false),
      type: DriftSqlType.int);
  late final GeneratedColumn<int> sold = GeneratedColumn<int>(
      'sold', aliasedName, false,
      generatedAs: GeneratedAs(productTable.sold, false),
      type: DriftSqlType.int);
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      generatedAs: GeneratedAs(categoryTable.title, false),
      type: DriftSqlType.string);
  @override
  $ProductViewView createAlias(String alias) {
    return $ProductViewView(attachedDatabase, alias);
  }

  @override
  Query? get query =>
      (attachedDatabase.selectOnly(categoryTable)..addColumns($columns)).join([
        innerJoin(
            productTable, productTable.categoryId.equalsExp(categoryTable.id))
      ]);
  @override
  Set<String> get readTables => const {'category_table', 'product_table'};
}

class $RoleTableTable extends RoleTable
    with TableInfo<$RoleTableTable, RoleTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoleTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? 'role_table';
  @override
  String get actualTableName => 'role_table';
  @override
  VerificationContext validateIntegrity(Insertable<RoleTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoleTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoleTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $RoleTableTable createAlias(String alias) {
    return $RoleTableTable(attachedDatabase, alias);
  }
}

class RoleTableData extends DataClass implements Insertable<RoleTableData> {
  final int id;
  final String name;
  const RoleTableData({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  RoleTableCompanion toCompanion(bool nullToAbsent) {
    return RoleTableCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory RoleTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoleTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  RoleTableData copyWith({int? id, String? name}) => RoleTableData(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('RoleTableData(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoleTableData &&
          other.id == this.id &&
          other.name == this.name);
}

class RoleTableCompanion extends UpdateCompanion<RoleTableData> {
  final Value<int> id;
  final Value<String> name;
  const RoleTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  RoleTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<RoleTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  RoleTableCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return RoleTableCompanion(
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
    return (StringBuffer('RoleTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $UserTableTable extends UserTable
    with TableInfo<$UserTableTable, UserTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => _uuid.v4());
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password =
      GeneratedColumn<String>('password', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 8,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _roleIdMeta = const VerificationMeta('roleId');
  @override
  late final GeneratedColumn<int> roleId = GeneratedColumn<int>(
      'role_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES role_table (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, username, password, createdAt, roleId];
  @override
  String get aliasedName => _alias ?? 'user_table';
  @override
  String get actualTableName => 'user_table';
  @override
  VerificationContext validateIntegrity(Insertable<UserTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('role_id')) {
      context.handle(_roleIdMeta,
          roleId.isAcceptableOrUnknown(data['role_id']!, _roleIdMeta));
    } else if (isInserting) {
      context.missing(_roleIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  UserTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      roleId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}role_id'])!,
    );
  }

  @override
  $UserTableTable createAlias(String alias) {
    return $UserTableTable(attachedDatabase, alias);
  }
}

class UserTableData extends DataClass implements Insertable<UserTableData> {
  final String id;
  final String username;
  final String password;
  final DateTime createdAt;
  final int roleId;
  const UserTableData(
      {required this.id,
      required this.username,
      required this.password,
      required this.createdAt,
      required this.roleId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['username'] = Variable<String>(username);
    map['password'] = Variable<String>(password);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['role_id'] = Variable<int>(roleId);
    return map;
  }

  UserTableCompanion toCompanion(bool nullToAbsent) {
    return UserTableCompanion(
      id: Value(id),
      username: Value(username),
      password: Value(password),
      createdAt: Value(createdAt),
      roleId: Value(roleId),
    );
  }

  factory UserTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserTableData(
      id: serializer.fromJson<String>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String>(json['password']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      roleId: serializer.fromJson<int>(json['roleId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String>(password),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'roleId': serializer.toJson<int>(roleId),
    };
  }

  UserTableData copyWith(
          {String? id,
          String? username,
          String? password,
          DateTime? createdAt,
          int? roleId}) =>
      UserTableData(
        id: id ?? this.id,
        username: username ?? this.username,
        password: password ?? this.password,
        createdAt: createdAt ?? this.createdAt,
        roleId: roleId ?? this.roleId,
      );
  @override
  String toString() {
    return (StringBuffer('UserTableData(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('createdAt: $createdAt, ')
          ..write('roleId: $roleId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, username, password, createdAt, roleId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserTableData &&
          other.id == this.id &&
          other.username == this.username &&
          other.password == this.password &&
          other.createdAt == this.createdAt &&
          other.roleId == this.roleId);
}

class UserTableCompanion extends UpdateCompanion<UserTableData> {
  final Value<String> id;
  final Value<String> username;
  final Value<String> password;
  final Value<DateTime> createdAt;
  final Value<int> roleId;
  final Value<int> rowid;
  const UserTableCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.roleId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserTableCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String password,
    this.createdAt = const Value.absent(),
    required int roleId,
    this.rowid = const Value.absent(),
  })  : username = Value(username),
        password = Value(password),
        roleId = Value(roleId);
  static Insertable<UserTableData> custom({
    Expression<String>? id,
    Expression<String>? username,
    Expression<String>? password,
    Expression<DateTime>? createdAt,
    Expression<int>? roleId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (createdAt != null) 'created_at': createdAt,
      if (roleId != null) 'role_id': roleId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? username,
      Value<String>? password,
      Value<DateTime>? createdAt,
      Value<int>? roleId,
      Value<int>? rowid}) {
    return UserTableCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
      roleId: roleId ?? this.roleId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (roleId.present) {
      map['role_id'] = Variable<int>(roleId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserTableCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('createdAt: $createdAt, ')
          ..write('roleId: $roleId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class UserViewData extends DataClass {
  final String id;
  final String username;
  final String name;
  final DateTime createdAt;
  const UserViewData(
      {required this.id,
      required this.username,
      required this.name,
      required this.createdAt});
  factory UserViewData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserViewData(
      id: serializer.fromJson<String>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'username': serializer.toJson<String>(username),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  UserViewData copyWith(
          {String? id, String? username, String? name, DateTime? createdAt}) =>
      UserViewData(
        id: id ?? this.id,
        username: username ?? this.username,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('UserViewData(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, username, name, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserViewData &&
          other.id == this.id &&
          other.username == this.username &&
          other.name == this.name &&
          other.createdAt == this.createdAt);
}

class $UserViewView extends ViewInfo<$UserViewView, UserViewData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$DatabaseApp attachedDatabase;
  $UserViewView(this.attachedDatabase, [this._alias]);
  $RoleTableTable get roleTable => attachedDatabase.roleTable.createAlias('t0');
  $UserTableTable get userTable => attachedDatabase.userTable.createAlias('t1');
  @override
  List<GeneratedColumn> get $columns => [id, username, name, createdAt];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'user_view';
  @override
  String? get createViewStmt => null;
  @override
  $UserViewView get asDslTable => this;
  @override
  UserViewData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserViewData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      generatedAs: GeneratedAs(userTable.id, false), type: DriftSqlType.string);
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      generatedAs: GeneratedAs(userTable.username, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      generatedAs: GeneratedAs(roleTable.name, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      generatedAs: GeneratedAs(userTable.createdAt, false),
      type: DriftSqlType.dateTime);
  @override
  $UserViewView createAlias(String alias) {
    return $UserViewView(attachedDatabase, alias);
  }

  @override
  Query? get query => (attachedDatabase.selectOnly(roleTable)
        ..addColumns($columns))
      .join([innerJoin(userTable, userTable.roleId.equalsExp(roleTable.id))]);
  @override
  Set<String> get readTables => const {'role_table', 'user_table'};
}

class DetailTransactionViewData extends DataClass {
  final String codeProduct;
  final String name;
  final int sellPrice;
  final int qty;
  final int total;
  final int id;
  const DetailTransactionViewData(
      {required this.codeProduct,
      required this.name,
      required this.sellPrice,
      required this.qty,
      required this.total,
      required this.id});
  factory DetailTransactionViewData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DetailTransactionViewData(
      codeProduct: serializer.fromJson<String>(json['codeProduct']),
      name: serializer.fromJson<String>(json['name']),
      sellPrice: serializer.fromJson<int>(json['sellPrice']),
      qty: serializer.fromJson<int>(json['qty']),
      total: serializer.fromJson<int>(json['total']),
      id: serializer.fromJson<int>(json['id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'codeProduct': serializer.toJson<String>(codeProduct),
      'name': serializer.toJson<String>(name),
      'sellPrice': serializer.toJson<int>(sellPrice),
      'qty': serializer.toJson<int>(qty),
      'total': serializer.toJson<int>(total),
      'id': serializer.toJson<int>(id),
    };
  }

  DetailTransactionViewData copyWith(
          {String? codeProduct,
          String? name,
          int? sellPrice,
          int? qty,
          int? total,
          int? id}) =>
      DetailTransactionViewData(
        codeProduct: codeProduct ?? this.codeProduct,
        name: name ?? this.name,
        sellPrice: sellPrice ?? this.sellPrice,
        qty: qty ?? this.qty,
        total: total ?? this.total,
        id: id ?? this.id,
      );
  @override
  String toString() {
    return (StringBuffer('DetailTransactionViewData(')
          ..write('codeProduct: $codeProduct, ')
          ..write('name: $name, ')
          ..write('sellPrice: $sellPrice, ')
          ..write('qty: $qty, ')
          ..write('total: $total, ')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(codeProduct, name, sellPrice, qty, total, id);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DetailTransactionViewData &&
          other.codeProduct == this.codeProduct &&
          other.name == this.name &&
          other.sellPrice == this.sellPrice &&
          other.qty == this.qty &&
          other.total == this.total &&
          other.id == this.id);
}

class $DetailTransactionViewView
    extends ViewInfo<$DetailTransactionViewView, DetailTransactionViewData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$DatabaseApp attachedDatabase;
  $DetailTransactionViewView(this.attachedDatabase, [this._alias]);
  $ProductTableTable get productTable =>
      attachedDatabase.productTable.createAlias('t0');
  $TransactionTableTable get transactionTable =>
      attachedDatabase.transactionTable.createAlias('t1');
  $DetailTransactionTableTable get detailTransactionTable =>
      attachedDatabase.detailTransactionTable.createAlias('t2');
  @override
  List<GeneratedColumn> get $columns =>
      [codeProduct, name, sellPrice, qty, total, id];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'detail_transaction_view';
  @override
  String? get createViewStmt => null;
  @override
  $DetailTransactionViewView get asDslTable => this;
  @override
  DetailTransactionViewData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DetailTransactionViewData(
      codeProduct: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code_product'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      sellPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sell_price'])!,
      qty: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}qty'])!,
      total: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
    );
  }

  late final GeneratedColumn<String> codeProduct = GeneratedColumn<String>(
      'code_product', aliasedName, false,
      generatedAs: GeneratedAs(productTable.codeProduct, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      generatedAs: GeneratedAs(productTable.name, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<int> sellPrice = GeneratedColumn<int>(
      'sell_price', aliasedName, false,
      generatedAs: GeneratedAs(productTable.sellPrice, false),
      type: DriftSqlType.int);
  late final GeneratedColumn<int> qty = GeneratedColumn<int>(
      'qty', aliasedName, false,
      generatedAs: GeneratedAs(detailTransactionTable.qty, false),
      type: DriftSqlType.int);
  late final GeneratedColumn<int> total = GeneratedColumn<int>(
      'total', aliasedName, false,
      generatedAs: GeneratedAs(detailTransactionTable.total, false),
      type: DriftSqlType.int);
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      generatedAs: GeneratedAs(transactionTable.id, false),
      type: DriftSqlType.int);
  @override
  $DetailTransactionViewView createAlias(String alias) {
    return $DetailTransactionViewView(attachedDatabase, alias);
  }

  @override
  Query? get query => (attachedDatabase.selectOnly(detailTransactionTable)
            ..addColumns($columns))
          .join([
        innerJoin(
            productTable,
            productTable.codeProduct
                .equalsExp(detailTransactionTable.codeProduct)),
        innerJoin(transactionTable,
            transactionTable.id.equalsExp(detailTransactionTable.idTransaction))
      ]);
  @override
  Set<String> get readTables =>
      const {'product_table', 'transaction_table', 'detail_transaction_table'};
}

abstract class _$DatabaseApp extends GeneratedDatabase {
  _$DatabaseApp(QueryExecutor e) : super(e);
  late final $CategoryTableTable categoryTable = $CategoryTableTable(this);
  late final $ProductTableTable productTable = $ProductTableTable(this);
  late final $CounterTransactionTableTable counterTransactionTable =
      $CounterTransactionTableTable(this);
  late final $TransactionTableTable transactionTable =
      $TransactionTableTable(this);
  late final $DetailTransactionTableTable detailTransactionTable =
      $DetailTransactionTableTable(this);
  late final $ProductViewView productView = $ProductViewView(this);
  late final $RoleTableTable roleTable = $RoleTableTable(this);
  late final $UserTableTable userTable = $UserTableTable(this);
  late final $UserViewView userView = $UserViewView(this);
  late final $DetailTransactionViewView detailTransactionView =
      $DetailTransactionViewView(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        categoryTable,
        productTable,
        counterTransactionTable,
        transactionTable,
        detailTransactionTable,
        productView,
        roleTable,
        userTable,
        userView,
        detailTransactionView
      ];
}
