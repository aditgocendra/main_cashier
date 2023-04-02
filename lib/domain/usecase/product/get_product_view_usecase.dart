import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/entity/product_entity.dart';
import 'package:main_cashier/domain/repostitories/product_repository.dart';

class GetProductView
    implements Usecase<List<ProductViewEntity>, ParamGetProductView> {
  final ProductRepository repository;

  GetProductView({
    required this.repository,
  });

  @override
  Future<List<ProductViewEntity>> call(ParamGetProductView parans) async {
    return await repository.getProductView(parans.limit, parans.offset);
  }
}

class ParamGetProductView {
  int limit;
  int offset;

  ParamGetProductView({
    required this.limit,
    required this.offset,
  });
}
