import 'package:main_cashier/data/models/category_model.dart';

import '../datasource/local/category_local_datasource.dart';
import '../../core/error/exception.dart';
import '../../domain/entity/category_entity.dart';
import '../../domain/repostitories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryLocalDataSource categoryLocalDataSource;

  CategoryRepositoryImpl({required this.categoryLocalDataSource});

  @override
  Future<CategoryEntity> createCategory(String title) async {
    try {
      return await categoryLocalDataSource.create(title);
    } catch (e) {
      throw InsertDataException('Fail insert categories');
    }
  }

  @override
  Future<List<CategoryEntity>> getCategories(int limit, int offset) async {
    try {
      return await categoryLocalDataSource.getAll(limit, offset);
    } catch (e) {
      throw FetchDataException('Fail get categories');
    }
  }

  @override
  Future<int> deleteCategory(CategoryEntity ctg) async {
    try {
      return await categoryLocalDataSource.delete(
        CategoryModel(
          id: ctg.id,
          title: ctg.title,
          createdAt: ctg.createdAt,
        ),
      );
    } catch (_) {
      throw FetchDataException('Fail delete category');
    }
  }

  @override
  Future<bool> updateCategory(CategoryEntity ctg) async {
    try {
      return await categoryLocalDataSource.update(
        CategoryModel(
          id: ctg.id,
          title: ctg.title,
          createdAt: ctg.createdAt,
        ),
      );
    } catch (_) {
      throw InsertDataException('Fail update category');
    }
  }

  @override
  Stream<List<CategoryEntity>> watchCategories() {
    try {
      return categoryLocalDataSource.watchAll();
    } catch (_) {
      throw FetchDataException('Fail stream data categories');
    }
  }
}
