import 'package:main_cashier/data/datasource/local/drift/drift_database.dart';
import 'package:main_cashier/domain/entity/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.code,
    required super.name,
    required super.capitalPrice,
    required super.sellPrice,
    required super.stock,
    required super.sold,
    required super.idCategory,
    required super.createdAt,
  });

  ProductTableData toTable(ProductModel productModel) {
    return ProductTableData(
      codeProduct: productModel.code,
      name: productModel.name,
      capitalPrice: productModel.capitalPrice,
      sellPrice: productModel.sellPrice,
      stock: productModel.stock,
      sold: productModel.sold,
      categoryId: productModel.idCategory,
      createdAt: productModel.createdAt,
    );
  }

  factory ProductModel.fromTable(ProductTableData data) {
    return ProductModel(
      code: data.codeProduct,
      name: data.name,
      capitalPrice: data.capitalPrice,
      sellPrice: data.sellPrice,
      stock: data.stock,
      sold: data.sold,
      idCategory: data.categoryId,
      createdAt: data.createdAt,
    );
  }

  static List<ProductModel> fromTableList(List<ProductTableData> data) {
    if (data.isEmpty) return [];
    return data.map((val) => ProductModel.fromTable(val)).toList();
  }
}

class ProductViewModel extends ProductViewEntity {
  ProductViewModel({
    required super.code,
    required super.name,
    required super.capitalPrice,
    required super.sellPrice,
    required super.stock,
    required super.sold,
    required super.titleCategory,
  });

  factory ProductViewModel.fromTable(ProductViewData data) {
    return ProductViewModel(
      code: data.codeProduct,
      name: data.name,
      capitalPrice: data.capitalPrice,
      sellPrice: data.sellPrice,
      stock: data.stock,
      sold: data.sold,
      titleCategory: data.title,
    );
  }

  static List<ProductViewModel> fromTableList(List<ProductViewData> data) {
    if (data.isEmpty) return [];
    return data.map((val) => ProductViewModel.fromTable(val)).toList();
  }
}
