import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

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
  IntColumn get roleId => integer().references(RoleTable, #id)();
}

class CategoryTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class ProductTable extends Table {
  TextColumn get codeProduct => text().unique()();
  TextColumn get name => text()();
  IntColumn get price => integer()();
  IntColumn get stock => integer()();
  IntColumn get sold => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  IntColumn get categoryId =>
      integer().references(CategoryTable, #id)(); // ForeignKey

  @override
  Set<Column> get primaryKey => {codeProduct};
}

abstract class ProductView extends View {
  CategoryTable get categoryTable;
  ProductTable get productTable;

  @override
  Query as() => select([
        productTable.codeProduct,
        productTable.name,
        productTable.price,
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

@DriftDatabase(
  tables: [CategoryTable, ProductTable],
  views: [ProductView, UserView],
)
class DatabaseApp extends _$DatabaseApp {
  DatabaseApp() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
