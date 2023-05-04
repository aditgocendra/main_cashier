import 'package:main_cashier/core/error/exception.dart';
import 'package:main_cashier/data/datasource/local/path_file_local_datasource.dart';
import 'package:main_cashier/data/models/path_file_model.dart';
import 'package:main_cashier/domain/entity/path_file_entity.dart';
import 'package:main_cashier/domain/repostitories/path_file_repository.dart';

class PathFileRepositoryImpl implements PathFileRepository {
  final PathFileLocalDataSource pathFileLocalDataSource;

  PathFileRepositoryImpl({
    required this.pathFileLocalDataSource,
  });

  @override
  Future<PathFileEntity> getPath(String folder) async {
    try {
      return await pathFileLocalDataSource.get(folder);
    } catch (_) {
      throw DatabaseDriftException("Fail get path folder");
    }
  }

  @override
  Future<List<PathFileEntity>> getPaths() async {
    try {
      return await pathFileLocalDataSource.getAll();
    } catch (_) {
      throw DatabaseDriftException("Fail get all path");
    }
  }

  @override
  Future<bool> updatePath(PathFileEntity pathFileEntity) async {
    try {
      return await pathFileLocalDataSource.update(PathFileModel(
        folder: pathFileEntity.folder,
        path: pathFileEntity.path,
      ));
    } catch (_) {
      throw DatabaseDriftException("Fail update path");
    }
  }
}
