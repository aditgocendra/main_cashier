import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/entity/product_entity.dart';
import 'package:main_cashier/domain/repostitories/product_repository.dart';

class GetProductCategories implements Usecase<List<ProductEntity>, int> {
  final ProductRepository repository;

  GetProductCategories({
    required this.repository,
  });

  @override
  Future<List<ProductEntity>> call(int params) async {
    return repository.getProductCategories(params);
  }
}
