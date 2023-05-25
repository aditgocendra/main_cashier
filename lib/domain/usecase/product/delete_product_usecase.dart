import 'package:main_cashier/core/usecase/usecase.dart';

import 'package:main_cashier/domain/repostitories/product_repository.dart';

class DeleteProduct implements Usecase<int, String> {
  final ProductRepository repository;

  DeleteProduct({
    required this.repository,
  });

  @override
  Future<int> call(String code) async {
    return await repository.deleteProduct(code);
  }
}
