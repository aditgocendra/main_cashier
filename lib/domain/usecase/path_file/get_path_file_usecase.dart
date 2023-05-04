import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/entity/path_file_entity.dart';
import 'package:main_cashier/domain/repostitories/path_file_repository.dart';

class GetPathFile implements Usecase<PathFileEntity, String> {
  final PathFileRepository repository;

  GetPathFile({
    required this.repository,
  });

  @override
  Future<PathFileEntity> call(String params) async {
    return await repository.getPath(params);
  }
}
