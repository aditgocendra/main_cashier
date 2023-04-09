import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/entity/product_entity.dart';
import 'package:main_cashier/domain/repostitories/product_repository.dart';

class SelectProduct implements Usecase<ProductEntity, String> {
  final ProductRepository repository;

  SelectProduct({
    required this.repository,
  });

  @override
  Future<ProductEntity> call(String code) async {
    return await repository.selectProduct(code);
  }
}
