import '../entity/role_entity.dart';

abstract class RoleRepository {
  Future<List<RoleEntity>> getRole();
}
