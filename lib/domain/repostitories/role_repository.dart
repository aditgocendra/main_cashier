import 'package:main_cashier/domain/entity/role_entity.dart';

abstract class RoleRepository {
  Future<RoleEntity> createRole(String name);

  Future<List<RoleEntity>> getRole();

  Future<bool> updateRole(RoleEntity roleEntity);

  Future<int> deleteRole(int id);
}
