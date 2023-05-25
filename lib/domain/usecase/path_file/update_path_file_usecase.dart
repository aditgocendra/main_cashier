import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/entity/path_file_entity.dart';
import 'package:main_cashier/domain/repostitories/path_file_repository.dart';

class UpdatePathFile implements Usecase<bool, PathFileEntity> {
  final PathFileRepository repository;

  UpdatePathFile({
    required this.repository,
  });

  @override
  Future<bool> call(PathFileEntity params) async {
    return await repository.updatePath(params);
  }
}
