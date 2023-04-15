import 'package:drift/isolate.dart';

import '../datasource/local/product_local_datasource.dart';
import '../models/product_model.dart';
import '../../core/error/exception.dart';
import '../../domain/entity/product_entity.dart';
import '../../domain/repostitories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource productLocalDataSource;

  ProductRepositoryImpl({
    required this.productLocalDataSource,
  });

  @override
  Future<ProductViewEntity> createProduct(ProductEntity productEntity) async {
    try {
      final result = await productLocalDataSource.codeProductIsExist(
        productEntity.code,
      );

      if (result) throw DatabaseDriftException("Code proruct is already exist");

      await productLocalDataSource.create(ProductModel(
        code: productEntity.code,
        name: productEntity.name,
        capitalPrice: productEntity.capitalPrice,
        sellPrice: productEntity.sellPrice,
        stock: productEntity.stock,
        sold: productEntity.sold,
        idCategory: productEntity.idCategory,
        createdAt: DateTime.now(),
      ));

      return await productLocalDataSource.selectView(productEntity.code);
    } on DriftRemoteException {
      throw DatabaseDriftException("Insert data product fail");
    }
  }

  @override
  Future<List<ProductViewEntity>> getProductView({
    required int limit,
    required int offset,
    required int orderColumn,
    required bool orderMode,
  }) async {
    try {
      return await productLocalDataSource.getView(
        limit: limit,
        offset: offset,
        orderColumn: orderColumn,
        orderMode: orderMode,
      );
    } on DatabaseDriftException {
      throw DatabaseDriftException("Fetch data product fail");
    }
  }

  @override
  Future<List<ProductViewEntity>> searchProduct(String keyword) async {
    try {
      return await productLocalDataSource.search(keyword);
    } catch (_) {
      throw DatabaseDriftException("Search product fail");
    }
  }

  @override
  Future<int> deleteProduct(String code) async {
    try {
      return await productLocalDataSource.delete(code);
    } catch (e) {
      throw DatabaseDriftException("Delete data product fail");
    }
  }

  @override
  Future<ProductViewEntity> updateProduct(ProductEntity productEntity) async {
    try {
      final result = await productLocalDataSource.update(ProductModel(
        code: productEntity.code,
        name: productEntity.name,
        capitalPrice: productEntity.capitalPrice,
        sellPrice: productEntity.sellPrice,
        stock: productEntity.stock,
        sold: productEntity.sold,
        idCategory: productEntity.idCategory,
        createdAt: productEntity.createdAt,
      ));

      if (!result) {
        throw DatabaseDriftException("Fail update product");
      }

      return await productLocalDataSource.selectView(productEntity.code);
    } catch (_) {
      throw DatabaseDriftException("Fail update product");
    }
  }

  @override
  Future<ProductEntity> selectProduct(String code) async {
    try {
      return await productLocalDataSource.select(code);
    } catch (_) {
      throw DatabaseDriftException("Fail select product");
    }
  }
}
