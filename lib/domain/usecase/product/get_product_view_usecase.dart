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
  Future<List<ProductViewEntity>> call(ParamGetProductView params) async {
    return await repository.getProductView(
      limit: params.limit,
      offset: params.offset,
      orderColumn: params.orderColumn,
      orderMode: params.orderSort,
    );
  }
}

class ParamGetProductView {
  int limit;
  int offset;
  int orderColumn;
  bool orderSort;

  ParamGetProductView({
    required this.limit,
    required this.offset,
    required this.orderColumn,
    required this.orderSort,
  });
}
