import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/repostitories/category_repository.dart';

class GetTotalCategory implements Usecase<int?, NoParans> {
  final CategoryRepository repository;

  GetTotalCategory({required this.repository});

  @override
  Future<int?> call(NoParans params) async {
    return await repository.getTotalCategory();
  }
}
