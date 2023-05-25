import 'drift/drift_database.dart';
import '../../models/role_model.dart';

abstract class RoleLocalDataSource {
  Future<List<RoleModel>> getAll();
}

class RoleLocalDataSourceImpl implements RoleLocalDataSource {
  final DatabaseApp databaseApp;

  RoleLocalDataSourceImpl({
    required this.databaseApp,
  });

  @override
  @override
  Future<List<RoleModel>> getAll() async {
    final result = await databaseApp.select(databaseApp.roleTable).get();
    return RoleModel.fromTableList(result);
  }
}
