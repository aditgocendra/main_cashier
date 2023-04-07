import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/entity/user_entity.dart';
import 'package:main_cashier/domain/repostitories/user_repository.dart';

class CreateUser implements Usecase<int, UserEntity> {
  final UserRepository repository;

  CreateUser({
    required this.repository,
  });

  @override
  Future<int> call(UserEntity userEntity) async {
    return await repository.createUser(userEntity);
  }
}
