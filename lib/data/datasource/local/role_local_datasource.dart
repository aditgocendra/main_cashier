import 'drift/drift_database.dart';
import '../../models/role_model.dart';

abstract class RoleLocalDataSource {
  Future<RoleModel> create(String name);

  Future<List<RoleModel>> getAll();

  Future<bool> update(
    RoleModel roleModel,
  );

  Future<int> delete(int id);
}

class RoleLocalDataSourceImpl implements RoleLocalDataSource {
  final DatabaseApp databaseApp;

  RoleLocalDataSourceImpl({
    required this.databaseApp,
  });

  @override
  Future<RoleModel> create(String name) async {
    final result = await databaseApp
        .into(databaseApp.roleTable)
        .insertReturning(RoleTableCompanion.insert(name: name));

    return RoleModel.fromTable(result);
  }

  @override
  Future<List<RoleModel>> getAll() async {
    final result = await databaseApp.select(databaseApp.roleTable).get();
    return RoleModel.fromTableList(result);
  }

  @override
  Future<int> delete(int id) async {
    return await (databaseApp.delete(databaseApp.roleTable)
          ..where(
            (tbl) => tbl.id.equals(id),
          ))
        .go();
  }

  @override
  Future<bool> update(RoleModel roleModel) async {
    return await databaseApp.update(databaseApp.roleTable).replace(
          roleModel.toTable(roleModel),
        );
  }
}
