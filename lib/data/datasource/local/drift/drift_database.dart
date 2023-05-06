import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

import '../../../../core/constant/color_constant.dart';
part 'drift_database.g.dart';

const _uuid = Uuid();

class RoleTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
}

class UserTable extends Table {
  TextColumn get id => text().clientDefault(() => _uuid.v4())();
  TextColumn get username => text().unique()();
  TextColumn get password => text().withLength(min: 8)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get roleId => integer().nullable().references(RoleTable, #id)();
}

class CategoryTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().unique()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class ProductTable extends Table {
  TextColumn get codeProduct => text().withLength(max: 14).unique()();
  TextColumn get name => text().withLength(max: 48).unique()();
  IntColumn get capitalPrice => integer()();
  IntColumn get sellPrice => integer()();
  IntColumn get stock => integer()();
  IntColumn get sold => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  IntColumn get categoryId =>
      integer().nullable().references(CategoryTable, #id)(); // ForeignKey

  @override
  Set<Column> get primaryKey => {codeProduct};
}

class CounterTransactionTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get totalTransaction => integer()();
  DateTimeColumn get date => dateTime()();
}

class TransactionTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get no => text().unique()();
  IntColumn get totalPay => integer()();
  DateTimeColumn get dateTransaction =>
      dateTime().withDefault(currentDateAndTime)();
}

class ProductTransactionTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get capitalPrice => integer()();
  IntColumn get sellPrice => integer()();
  IntColumn get qty => integer()();
  IntColumn get total => integer()();
  IntColumn get idTransaction =>
      integer().nullable().references(TransactionTable, #id)();
}

class ColorAppTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get primary => integer()();
  IntColumn get primaryLight => integer()();
  IntColumn get background => integer()();
  IntColumn get canvas => integer()();
  IntColumn get border => integer()();
}

class PathFileTable extends Table {
  TextColumn get folder => text().unique()();
  TextColumn get path => text()();

  @override
  Set<Column> get primaryKey => {folder};
}

abstract class ProductView extends View {
  CategoryTable get categoryTable;
  ProductTable get productTable;

  @override
  Query as() => select([
        productTable.codeProduct,
        productTable.name,
        productTable.capitalPrice,
        productTable.sellPrice,
        productTable.stock,
        productTable.sold,
        categoryTable.title,
      ]).from(categoryTable).join(
        [
          innerJoin(
            productTable,
            productTable.categoryId.equalsExp(categoryTable.id),
          ),
        ],
      );
}

abstract class UserView extends View {
  RoleTable get roleTable;
  UserTable get userTable;

  @override
  Query as() => select([
        userTable.id,
        userTable.username,
        roleTable.name,
        userTable.createdAt,
      ]).from(roleTable).join(
        [
          innerJoin(
            userTable,
            userTable.roleId.equalsExp(
              roleTable.id,
            ),
          )
        ],
      );
}

abstract class ProductTransactionView extends View {
  ProductTable get productTable;
  TransactionTable get transactionTable;
  ProductTransactionTable get productTransactionTable;

  @override
  Query as() => select([
        transactionTable.no,
        productTransactionTable.name,
        productTransactionTable.capitalPrice,
        productTransactionTable.sellPrice,
        productTransactionTable.qty,
        productTransactionTable.total,
        transactionTable.id,
        transactionTable.dateTransaction,
      ]).from(productTransactionTable).join([
        innerJoin(
          transactionTable,
          transactionTable.id.equalsExp(
            productTransactionTable.idTransaction,
          ),
        )
      ]);
}

@DriftDatabase(
  tables: [
    CategoryTable,
    ProductTable,
    CounterTransactionTable,
    TransactionTable,
    ProductTransactionTable,
    ColorAppTable,
    PathFileTable,
  ],
  views: [
    ProductView,
    UserView,
    ProductTransactionView,
  ],
)
class DatabaseApp extends _$DatabaseApp {
  DatabaseApp() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        if (details.wasCreated) {
          await batch((batch) {
            batch.insertAll(roleTable, [
              RoleTableCompanion.insert(name: "Admin"),
              RoleTableCompanion.insert(name: "Cashier"),
            ]);
          });

          await into(counterTransactionTable).insert(
            CounterTransactionTableCompanion.insert(
              totalTransaction: 1,
              date: DateTime.now(),
            ),
          );

          await into(colorAppTable).insert(ColorAppTableCompanion.insert(
            primary: primaryColor.value,
            primaryLight: primaryLightColor.value,
            background: backgroundColor.value,
            canvas: canvasColor.value,
            border: borderColor.value,
          ));

          final pathFolder = await getApplicationDocumentsDirectory();

          await into(pathFileTable).insert(PathFileTableCompanion.insert(
            folder: "invoice",
            path: pathFolder.path,
          ));

          await into(pathFileTable).insert(PathFileTableCompanion.insert(
            folder: "report",
            path: pathFolder.path,
          ));
        }
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationSupportDirectory();
    final file = File(path.join(dbFolder.path, 'app.db'));
    return NativeDatabase.createInBackground(file);
  });
}
