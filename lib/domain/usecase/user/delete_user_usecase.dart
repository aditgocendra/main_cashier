import 'package:main_cashier/core/usecase/usecase.dart';

import '../../repostitories/user_repository.dart';

class DeleteUser implements Usecase<int, String> {
  final UserRepository repository;

  DeleteUser({
    required this.repository,
  });
  @override
  Future<int> call(String uid) async {
    return await repository.deleteUser(uid);
  }
}
