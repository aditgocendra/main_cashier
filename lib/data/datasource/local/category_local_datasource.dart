import 'package:drift/drift.dart';

import 'drift/drift_database.dart';
import '../../models/category_model.dart';

abstract class CategoryLocalDataSource {
  Future<List<CategoryModel>> getAll(int limit, int offset);

  Future<List<CategoryModel>> search(String keyword);

  Future<CategoryModel> create(String title);

  Future<bool> update(CategoryModel categoryModel);

  Future<int> delete(CategoryModel categoryModel);
}

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  final DatabaseApp databaseApp;

  CategoryLocalDataSourceImpl({
    required this.databaseApp,
  });

  @override
  Future<List<CategoryModel>> getAll(int limit, int offset) async {
    final result = limit != 0
        ? await (databaseApp.select(databaseApp.categoryTable)
              ..limit(limit, offset: offset))
            .get()
        : await databaseApp.select(databaseApp.categoryTable).get();

    return CategoryModel.fromTableList(result);
  }

  @override
  Future<CategoryModel> create(String title) async {
    final result =
        await databaseApp.into(databaseApp.categoryTable).insertReturning(
              CategoryTableCompanion.insert(
                title: title,
              ),
            );

    return CategoryModel.fromTable(result);
  }

  @override
  Future<bool> update(CategoryModel categoryModel) async {
    return await databaseApp.update(databaseApp.categoryTable).replace(
          categoryModel.toTable(categoryModel),
        );
  }

  @override
  Future<int> delete(CategoryModel categoryModel) async {
    return await databaseApp
        .delete(databaseApp.categoryTable)
        .delete(categoryModel.toTable(categoryModel));
  }

  @override
  Future<List<CategoryModel>> search(String keyword) async {
    final result = await (databaseApp.select(databaseApp.categoryTable)
          ..where(
            (tbl) => tbl.title.like('%$keyword%'),
          ))
        .get();

    return CategoryModel.fromTableList(result);
  }
}
