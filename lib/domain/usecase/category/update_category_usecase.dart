import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/entity/category_entity.dart';
import 'package:main_cashier/domain/repostitories/category_repository.dart';

class UpdateCategory implements Usecase<bool, CategoryEntity> {
  final CategoryRepository repository;

  UpdateCategory({required this.repository});

  @override
  Future<bool> call(CategoryEntity category) async {
    return await repository.updateCategory(category);
  }
}
