import '../../../core/usecase/usecase.dart';
import '../../entity/category_entity.dart';
import '../../repostitories/category_repository.dart';

class GetCategories implements Usecase<List<CategoryEntity>, NoParans> {
  final CategoryRepository repository;

  GetCategories({
    required this.repository,
  });

  @override
  Future<List<CategoryEntity>> call(NoParans params) async {
    return repository.getCategories();
  }
}
