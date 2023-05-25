import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/entity/category_entity.dart';
import '../../repostitories/category_repository.dart';

class DeleteCategory implements Usecase<int, CategoryEntity> {
  final CategoryRepository repository;

  DeleteCategory({
    required this.repository,
  });

  @override
  Future<int> call(CategoryEntity categoryEntity) async {
    return await repository.deleteCategory(categoryEntity);
  }
}
