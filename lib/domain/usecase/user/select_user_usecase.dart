import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/entity/user_entity.dart';
import 'package:main_cashier/domain/repostitories/user_repository.dart';

class SelectUser implements Usecase<UserEntity, String> {
  final UserRepository repository;

  SelectUser({
    required this.repository,
  });

  @override
  Future<UserEntity> call(String params) async {
    return await repository.selectUser(params);
  }
}
