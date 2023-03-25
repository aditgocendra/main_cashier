import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

part 'drift_database.g.dart';

class CategoryTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class ProductTable extends Table {
  IntColumn get codeProduct => integer().unique()();
  TextColumn get name => text()();
  IntColumn get price => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  IntColumn get categoryId =>
      integer().references(CategoryTable, #id)(); // ForeignKey
}

abstract class ProductCategoryView extends View {
  CategoryTable get categoryTable;
  ProductTable get productTable;

  @override
  Query as() => select([
        productTable.name,
        productTable.price,
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

@DriftDatabase(
  tables: [CategoryTable, ProductTable],
  views: [ProductCategoryView],
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
