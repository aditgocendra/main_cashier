import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/entity/role_entity.dart';
import 'package:main_cashier/domain/repostitories/role_repository.dart';

class UpdateRole implements Usecase<bool, RoleEntity> {
  final RoleRepository repository;

  UpdateRole({
    required this.repository,
  });

  @override
  Future<bool> call(RoleEntity roleEntity) async {
    return await repository.updateRole(roleEntity);
  }
}
