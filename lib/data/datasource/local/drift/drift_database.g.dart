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
      type: DriftSqlType.string, requiredDuringInsert: true);
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
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<int> price = GeneratedColumn<int>(
      'price', aliasedName, false,
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
  List<GeneratedColumn> get $columns =>
      [codeProduct, name, price, stock, sold, createdAt, updatedAt, categoryId];
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
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
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
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}price'])!,
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
  final int price;
  final int stock;
  final int sold;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int categoryId;
  const ProductTableData(
      {required this.codeProduct,
      required this.name,
      required this.price,
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
    map['price'] = Variable<int>(price);
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
      price: Value(price),
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
      price: serializer.fromJson<int>(json['price']),
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
      'price': serializer.toJson<int>(price),
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
          int? price,
          int? stock,
          int? sold,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent(),
          int? categoryId}) =>
      ProductTableData(
        codeProduct: codeProduct ?? this.codeProduct,
        name: name ?? this.name,
        price: price ?? this.price,
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
          ..write('price: $price, ')
          ..write('stock: $stock, ')
          ..write('sold: $sold, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('categoryId: $categoryId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      codeProduct, name, price, stock, sold, createdAt, updatedAt, categoryId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductTableData &&
          other.codeProduct == this.codeProduct &&
          other.name == this.name &&
          other.price == this.price &&
          other.stock == this.stock &&
          other.sold == this.sold &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.categoryId == this.categoryId);
}

class ProductTableCompanion extends UpdateCompanion<ProductTableData> {
  final Value<String> codeProduct;
  final Value<String> name;
  final Value<int> price;
  final Value<int> stock;
  final Value<int> sold;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> categoryId;
  final Value<int> rowid;
  const ProductTableCompanion({
    this.codeProduct = const Value.absent(),
    this.name = const Value.absent(),
    this.price = const Value.absent(),
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
    required int price,
    required int stock,
    this.sold = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required int categoryId,
    this.rowid = const Value.absent(),
  })  : codeProduct = Value(codeProduct),
        name = Value(name),
        price = Value(price),
        stock = Value(stock),
        categoryId = Value(categoryId);
  static Insertable<ProductTableData> custom({
    Expression<String>? codeProduct,
    Expression<String>? name,
    Expression<int>? price,
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
      if (price != null) 'price': price,
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
      Value<int>? price,
      Value<int>? stock,
      Value<int>? sold,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? categoryId,
      Value<int>? rowid}) {
    return ProductTableCompanion(
      codeProduct: codeProduct ?? this.codeProduct,
      name: name ?? this.name,
      price: price ?? this.price,
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
    if (price.present) {
      map['price'] = Variable<int>(price.value);
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
          ..write('price: $price, ')
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

class ProductViewData extends DataClass {
  final String codeProduct;
  final String name;
  final int price;
  final int stock;
  final int sold;
  final String title;
  const ProductViewData(
      {required this.codeProduct,
      required this.name,
      required this.price,
      required this.stock,
      required this.sold,
      required this.title});
  factory ProductViewData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductViewData(
      codeProduct: serializer.fromJson<String>(json['codeProduct']),
      name: serializer.fromJson<String>(json['name']),
      price: serializer.fromJson<int>(json['price']),
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
      'price': serializer.toJson<int>(price),
      'stock': serializer.toJson<int>(stock),
      'sold': serializer.toJson<int>(sold),
      'title': serializer.toJson<String>(title),
    };
  }

  ProductViewData copyWith(
          {String? codeProduct,
          String? name,
          int? price,
          int? stock,
          int? sold,
          String? title}) =>
      ProductViewData(
        codeProduct: codeProduct ?? this.codeProduct,
        name: name ?? this.name,
        price: price ?? this.price,
        stock: stock ?? this.stock,
        sold: sold ?? this.sold,
        title: title ?? this.title,
      );
  @override
  String toString() {
    return (StringBuffer('ProductViewData(')
          ..write('codeProduct: $codeProduct, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('stock: $stock, ')
          ..write('sold: $sold, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(codeProduct, name, price, stock, sold, title);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductViewData &&
          other.codeProduct == this.codeProduct &&
          other.name == this.name &&
          other.price == this.price &&
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
      [codeProduct, name, price, stock, sold, title];
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
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}price'])!,
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
  late final GeneratedColumn<int> price = GeneratedColumn<int>(
      'price', aliasedName, false,
      generatedAs: GeneratedAs(productTable.price, false),
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

abstract class _$DatabaseApp extends GeneratedDatabase {
  _$DatabaseApp(QueryExecutor e) : super(e);
  late final $CategoryTableTable categoryTable = $CategoryTableTable(this);
  late final $ProductTableTable productTable = $ProductTableTable(this);
  late final $ProductViewView productView = $ProductViewView(this);
  late final $RoleTableTable roleTable = $RoleTableTable(this);
  late final $UserTableTable userTable = $UserTableTable(this);
  late final $UserViewView userView = $UserViewView(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        categoryTable,
        productTable,
        productView,
        roleTable,
        userTable,
        userView
      ];
}
