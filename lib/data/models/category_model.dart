import 'package:main_cashier/data/datasource/local/drift/drift_database.dart';
import 'package:main_cashier/domain/entity/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({
    required super.id,
    required super.title,
    required super.createdAt,
  });

  CategoryTableData toTable(CategoryModel categoryModel) {
    return CategoryTableData(
      id: categoryModel.id,
      title: categoryModel.title,
      createdAt: categoryModel.createdAt,
    );
  }

  factory CategoryModel.fromTable(CategoryTableData data) {
    return CategoryModel(
      id: data.id,
      title: data.title,
      createdAt: data.createdAt,
    );
  }

  static List<CategoryModel> fromTableList(List<CategoryTableData> data) {
    if (data.isEmpty) return [];
    return data.map((val) => CategoryModel.fromTable(val)).toList();
  }
}
