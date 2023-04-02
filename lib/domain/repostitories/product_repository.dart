import 'package:main_cashier/domain/entity/product_entity.dart';

abstract class ProductRepository {
  Future<ProductViewEntity> createProduct(ProductEntity productEntity);

  Future<List<ProductViewEntity>> getProductView(int limit, int offset);

  Future<List<ProductViewEntity>> searchProduct(String keyword);

  Future<int> deleteProduct(String code);

  Future<ProductViewEntity> updateProduct(ProductEntity productEntity);
}
