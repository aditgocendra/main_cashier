import 'package:main_cashier/domain/entity/path_file_entity.dart';

abstract class PathFileRepository {
  Future<PathFileEntity> getPath(String folder);

  Future<List<PathFileEntity>> getPaths();

  Future<bool> updatePath(PathFileEntity pathFileEntity);
}
