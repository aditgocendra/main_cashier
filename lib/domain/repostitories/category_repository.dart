import 'package:main_cashier/domain/entity/category_entity.dart';

abstract class CategoryRepository {
  Stream<List<CategoryEntity>> watchCategories();

  Future<List<CategoryEntity>> getCategories();

  Future<CategoryEntity> createCategory(String title);

  Future<bool> updateCategory(CategoryEntity ctg);

  Future<int> deleteCategory(CategoryEntity ctg);
}
