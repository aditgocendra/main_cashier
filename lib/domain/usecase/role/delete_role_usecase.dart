import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/repostitories/role_repository.dart';

class DeleteRole implements Usecase<int, int> {
  final RoleRepository repository;

  DeleteRole({
    required this.repository,
  });

  @override
  Future<int> call(int id) async {
    return repository.deleteRole(id);
  }
}
