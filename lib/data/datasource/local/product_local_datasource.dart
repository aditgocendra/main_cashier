import 'package:drift/drift.dart';

import 'drift/drift_database.dart';
import '../../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductViewModel>> getView();

  Future<bool> codeProductIsExist(String code);

  Future<int> create(ProductModel productModel);

  Future<ProductViewModel> select(String code);

  Future<int> delete(String code);

  Future<bool> update(ProductModel productModel);

  Future<List<ProductViewModel>> search(String keyword);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final DatabaseApp databaseApp;

  ProductLocalDataSourceImpl({
    required this.databaseApp,
  });

  @override
  Future<int> create(ProductModel productModel) async {
    return await databaseApp
        .into(databaseApp.productTable)
        .insert(ProductTableCompanion.insert(
          codeProduct: productModel.code,
          name: productModel.name,
          price: productModel.price,
          stock: productModel.stock,
          categoryId: productModel.idCategory,
        ));
  }

  @override
  Future<int> delete(String code) async {
    return await (databaseApp.delete(databaseApp.productTable)
          ..where((tbl) => tbl.codeProduct.equals(code)))
        .go();
  }

  @override
  Future<List<ProductViewModel>> getView() async {
    final result = await databaseApp.select(databaseApp.productView).get();
    return ProductViewModel.fromTableList(result);
  }

  @override
  Future<bool> codeProductIsExist(String code) async {
    final result = await (databaseApp.select(databaseApp.productTable)
          ..where((tbl) => tbl.codeProduct.equals(code)))
        .get();

    return result.isNotEmpty ? true : false;
  }

  @override
  Future<bool> update(ProductModel productModel) async {
    return await databaseApp.update(databaseApp.productTable).replace(
          productModel.toTable(productModel),
        );
  }

  @override
  Future<List<ProductViewModel>> search(String keyword) async {
    final result = await (databaseApp.select(databaseApp.productView)
          ..where((tbl) => tbl.name.like('%$keyword%')))
        .get();
    return ProductViewModel.fromTableList(result);
  }

  @override
  Future<ProductViewModel> select(String code) async {
    final result = await (databaseApp.select(databaseApp.productView)
          ..where((tbl) => tbl.codeProduct.equals(code)))
        .getSingle();

    return ProductViewModel.fromTable(result);
  }
}
