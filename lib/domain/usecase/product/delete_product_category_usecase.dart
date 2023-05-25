import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/repostitories/product_repository.dart';

class DeleteProductCategory implements Usecase<int, int> {
  final ProductRepository repository;

  DeleteProductCategory({
    required this.repository,
  });

  @override
  Future<int> call(int params) async {
    return await repository.deleteProductInCategory(params);
  }
}
