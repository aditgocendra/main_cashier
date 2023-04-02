import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/entity/product_entity.dart';
import 'package:main_cashier/domain/repostitories/product_repository.dart';

class UpdateProduct implements Usecase<ProductViewEntity, ProductEntity> {
  final ProductRepository repository;

  UpdateProduct({
    required this.repository,
  });

  @override
  Future<ProductViewEntity> call(ProductEntity productEntity) async {
    return await repository.updateProduct(productEntity);
  }
}
