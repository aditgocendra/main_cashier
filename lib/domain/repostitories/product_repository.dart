import 'package:main_cashier/domain/entity/product_entity.dart';

abstract class ProductRepository {
  Future<ProductViewEntity> createProduct(ProductEntity productEntity);

  Future<List<ProductViewEntity>> getProductView({
    required int limit,
    required int offset,
    required int orderColumn,
    required bool orderMode,
  });

  Future<List<ProductViewEntity>> searchProduct(String keyword);

  Future<int> deleteProduct(String code);

  Future<ProductViewEntity> updateProduct(ProductEntity productEntity);

  Future<ProductEntity> selectProduct(String code);
}
