import 'drift/drift_database.dart';
import '../../models/category_model.dart';

abstract class CategoryLocalDataSource {
  Future<List<CategoryModel>> getAll();

  Stream<List<CategoryModel>> watchAll();

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
  Future<List<CategoryModel>> getAll() async {
    final result = await databaseApp.select(databaseApp.categoryTable).get();

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
  Stream<List<CategoryModel>> watchAll() {
    final query = databaseApp.select(databaseApp.categoryTable);

    return query
        .map(
          (row) => CategoryModel(
            id: row.id,
            title: row.title,
            createdAt: row.createdAt,
          ),
        )
        .watch();
  }
}
