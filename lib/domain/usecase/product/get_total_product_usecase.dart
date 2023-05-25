import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/repostitories/product_repository.dart';

class GetTotalProduct implements Usecase<int?, NoParans> {
  final ProductRepository repository;

  GetTotalProduct({
    required this.repository,
  });

  @override
  Future<int?> call(NoParans params) async {
    return await repository.getTotalProduct();
  }
}
