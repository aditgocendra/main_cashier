import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/entity/category_entity.dart';
import 'package:main_cashier/domain/repostitories/category_repository.dart';

class SearchCategories implements Usecase<List<CategoryEntity>, String> {
  final CategoryRepository repository;

  SearchCategories({
    required this.repository,
  });

  @override
  Future<List<CategoryEntity>> call(String keyword) async {
    return await repository.searchCategories(keyword);
  }
}
