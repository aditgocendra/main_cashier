import '../../../core/usecase/usecase.dart';
import '../../entity/category_entity.dart';
import '../../repostitories/category_repository.dart';

class CreateCategory implements Usecase<CategoryEntity, String> {
  final CategoryRepository repository;

  CreateCategory({
    required this.repository,
  });

  @override
  Future<CategoryEntity> call(String title) async {
    return await repository.createCategory(title);
  }
}
