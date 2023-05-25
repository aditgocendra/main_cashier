import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/entity/product_entity.dart';
import 'package:main_cashier/domain/repostitories/product_repository.dart';

class SearchProduct implements Usecase<List<ProductViewEntity>, String> {
  final ProductRepository repository;

  SearchProduct({
    required this.repository,
  });

  @override
  Future<List<ProductViewEntity>> call(String keyword) async {
    return await repository.searchProduct(keyword);
  }
}
