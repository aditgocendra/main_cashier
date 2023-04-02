import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/entity/product_entity.dart';

import '../../repostitories/product_repository.dart';

class CreateProduct implements Usecase<ProductViewEntity, ProductEntity> {
  final ProductRepository repository;

  CreateProduct({
    required this.repository,
  });

  @override
  Future<ProductViewEntity> call(ProductEntity productEntity) async {
    return await repository.createProduct(productEntity);
  }
}
