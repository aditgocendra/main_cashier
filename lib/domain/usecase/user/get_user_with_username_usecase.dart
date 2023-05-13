import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/entity/user_entity.dart';
import 'package:main_cashier/domain/repostitories/user_repository.dart';

class GetUserWithUsername implements Usecase<UserEntity, String> {
  final UserRepository repository;

  GetUserWithUsername({
    required this.repository,
  });

  @override
  Future<UserEntity> call(String params) async {
    return repository.getUserWithUsername(params);
  }
}
