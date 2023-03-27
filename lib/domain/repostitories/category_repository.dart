import 'package:main_cashier/domain/entity/category_entity.dart';

abstract class CategoryRepository {
  Future<List<CategoryEntity>> getCategories(int limit, int offset);

  Future<List<CategoryEntity>> searchCategories(String keyword);

  Future<CategoryEntity> createCategory(String title);

  Future<bool> updateCategory(CategoryEntity ctg);

  Future<int> deleteCategory(CategoryEntity ctg);
}
