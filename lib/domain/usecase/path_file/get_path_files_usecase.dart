import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/entity/path_file_entity.dart';
import 'package:main_cashier/domain/repostitories/path_file_repository.dart';

class GetPathFiles implements Usecase<List<PathFileEntity>, NoParans> {
  final PathFileRepository repository;

  GetPathFiles({
    required this.repository,
  });

  @override
  Future<List<PathFileEntity>> call(NoParans params) async {
    return await repository.getPaths();
  }
}
