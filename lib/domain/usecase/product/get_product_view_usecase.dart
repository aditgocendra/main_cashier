import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/entity/product_entity.dart';
import 'package:main_cashier/domain/repostitories/product_repository.dart';

class GetProductView implements Usecase<List<ProductViewEntity>, NoParans> {
  final ProductRepository repository;

  GetProductView({
    required this.repository,
  });

  @override
  Future<List<ProductViewEntity>> call(NoParans parans) async {
    return await repository.getProductView();
  }
}
