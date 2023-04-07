import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/entity/role_entity.dart';
import 'package:main_cashier/domain/repostitories/role_repository.dart';

class CreateRole implements Usecase<RoleEntity, String> {
  final RoleRepository repository;

  CreateRole({
    required this.repository,
  });

  @override
  Future<RoleEntity> call(String name) async {
    return await repository.createRole(name);
  }
}
