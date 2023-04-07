import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/entity/role_entity.dart';
import 'package:main_cashier/domain/repostitories/role_repository.dart';

class GetRole implements Usecase<List<RoleEntity>, NoParans> {
  final RoleRepository repository;

  GetRole({
    required this.repository,
  });

  @override
  Future<List<RoleEntity>> call(NoParans params) async {
    return await repository.getRole();
  }
}
