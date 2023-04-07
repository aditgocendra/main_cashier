import 'package:main_cashier/domain/entity/user_entity.dart';

abstract class UserRepository {
  Future<int> createUser(UserEntity userEntity);

  Future updateUser({
    required String uid,
    required String newUsername,
    required int newRole,
  });

  Future changePasswordUser({
    required String uid,
    required String pass,
  });

  Future<int> deleteUser(String uid);

  Future<List<UserViewEntity>> getViewUser({
    required int limit,
    required int offset,
  });
}
