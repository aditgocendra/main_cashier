import '../../../core/usecase/usecase.dart';
import '../../entity/category_entity.dart';
import '../../repostitories/category_repository.dart';

class GetCategories
    implements Usecase<List<CategoryEntity>, ParamGetCategories> {
  final CategoryRepository repository;

  GetCategories({
    required this.repository,
  });

  @override
  Future<List<CategoryEntity>> call(ParamGetCategories params) async {
    return repository.getCategories(params.limit, params.offset);
  }
}

class ParamGetCategories {
  int limit;
  int offset;

  ParamGetCategories({
    required this.limit,
    required this.offset,
  });
}
