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
      throw DatabaseDriftException('Fail insert categories');
    }
  }

  @override
  Future<List<CategoryEntity>> getCategories(int limit, int offset) async {
    try {
      return await categoryLocalDataSource.getAll(limit, offset);
    } catch (e) {
      throw DatabaseDriftException('Fail get categories');
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
      throw DatabaseDriftException('Fail delete category');
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
      throw DatabaseDriftException('Fail update category');
    }
  }

  @override
  Future<List<CategoryEntity>> searchCategories(String keyword) async {
    try {
      return await categoryLocalDataSource.search(keyword);
    } catch (e) {
      throw DatabaseDriftException('Fail search keyword $keyword in category');
    }
  }

  @override
  Future<int?> getTotalCategory() async {
    try {
      return await categoryLocalDataSource.getTotal();
    } catch (_) {
      throw DatabaseDriftException("Fail get total category");
    }
  }
}
