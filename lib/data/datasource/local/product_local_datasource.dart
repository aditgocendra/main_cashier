import 'package:drift/drift.dart';

import 'drift/drift_database.dart';
import '../../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductViewModel>> getView({
    required int limit,
    required int offset,
    required int orderColumn,
    required bool orderMode,
  });

  Future<bool> codeProductIsExist(String code);

  Future<int> create(ProductModel productModel);

  Future<ProductViewModel> selectView(String code);

  Future<ProductModel> select(String code);

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
          capitalPrice: productModel.capitalPrice,
          sellPrice: productModel.sellPrice,
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

  // OrderingMode by value sort, true ? Ascending : Descending
  // Order Column : 0 = Sold, 1 = Name, 2 = Price, 3 = Stock, Default = CodeProduct
  @override
  Future<List<ProductViewModel>> getView({
    required int limit,
    required int offset,
    required int orderColumn,
    required bool orderMode,
  }) async {
    final result = await ((databaseApp.select(databaseApp.productView)
          ..orderBy([
            (tbl) => OrderingTerm(
                expression: (orderColumn == 1)
                    ? tbl.name
                    : (orderColumn == 2)
                        ? tbl.capitalPrice
                        : (orderColumn == 3)
                            ? tbl.sellPrice
                            : (orderColumn == 4)
                                ? tbl.sold
                                : (orderColumn == 5)
                                    ? tbl.stock
                                    : tbl.codeProduct,
                mode: orderMode ? OrderingMode.desc : OrderingMode.asc)
          ]))
          ..limit(limit, offset: offset))
        .get();
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
  Future<ProductViewModel> selectView(String code) async {
    final result = await (databaseApp.select(databaseApp.productView)
          ..where((tbl) => tbl.codeProduct.equals(code)))
        .getSingle();

    return ProductViewModel.fromTable(result);
  }

  @override
  Future<ProductModel> select(String code) async {
    final result = await (databaseApp.select(databaseApp.productTable)
          ..where((tbl) => tbl.codeProduct.equals(code)))
        .getSingle();

    return ProductModel.fromTable(result);
  }
}
