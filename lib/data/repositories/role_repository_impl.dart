import 'package:main_cashier/data/datasource/local/role_local_datasource.dart';
import 'package:main_cashier/data/models/role_model.dart';
import 'package:main_cashier/domain/entity/role_entity.dart';
import 'package:main_cashier/domain/repostitories/role_repository.dart';

import '../../core/error/exception.dart';

class RoleRepositoryImpl implements RoleRepository {
  final RoleLocalDataSource roleLocalDataSource;

  RoleRepositoryImpl({
    required this.roleLocalDataSource,
  });

  @override
  Future<RoleEntity> createRole(String name) async {
    try {
      return await roleLocalDataSource.create(name);
    } catch (_) {
      throw DatabaseDriftException("Insert data role fail");
    }
  }

  @override
  Future<List<RoleEntity>> getRole() async {
    try {
      return await roleLocalDataSource.getAll();
    } catch (_) {
      throw DatabaseDriftException("Fetch data role fail");
    }
  }

  @override
  Future<int> deleteRole(int id) async {
    try {
      return await roleLocalDataSource.delete(id);
    } catch (_) {
      throw DatabaseDriftException("Delete data role fail");
    }
  }

  @override
  Future<bool> updateRole(RoleEntity roleEntity) async {
    try {
      return await roleLocalDataSource.update(
        RoleModel(
          id: roleEntity.id,
          name: roleEntity.name,
        ),
      );
    } catch (e) {
      throw DatabaseDriftException("Update data role fail");
    }
  }
}
