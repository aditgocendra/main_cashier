import '../datasource/local/role_local_datasource.dart';
import '../../domain/entity/role_entity.dart';
import '../../domain/repostitories/role_repository.dart';

import '../../core/error/exception.dart';

class RoleRepositoryImpl implements RoleRepository {
  final RoleLocalDataSource roleLocalDataSource;

  RoleRepositoryImpl({
    required this.roleLocalDataSource,
  });

  @override
  Future<List<RoleEntity>> getRole() async {
    try {
      return await roleLocalDataSource.getAll();
    } catch (_) {
      throw DatabaseDriftException("Fetch data role fail");
    }
  }
}
