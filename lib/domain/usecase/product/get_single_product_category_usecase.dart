import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/entity/product_entity.dart';
import 'package:main_cashier/domain/repostitories/product_repository.dart';

class GetSingleProductCategory implements Usecase<ProductEntity?, int> {
  final ProductRepository repository;

  GetSingleProductCategory({
    required this.repository,
  });

  @override
  Future<ProductEntity?> call(int params) async {
    return repository.getSingleProductCategory(params);
  }
}
