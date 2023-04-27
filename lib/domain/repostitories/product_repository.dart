import 'package:main_cashier/domain/entity/product_entity.dart';

abstract class ProductRepository {
  Future<ProductViewEntity> createProduct(ProductEntity productEntity);

  Future<List<ProductViewEntity>> getProductView({
    required int limit,
    required int offset,
    required int orderColumn,
    required bool orderMode,
  });

  Future<ProductEntity?> getSingleProductCategory(int idCategory);

  Future<List<ProductViewEntity>> searchProduct(String keyword);

  Future<int> deleteProduct(String code);

  Future<int> deleteProductInCategory(int idCategory);

  Future<ProductViewEntity> updateProduct(ProductEntity productEntity);

  Future<ProductEntity> selectProduct(String code);

  Future<int?> getTotalProduct();
}
