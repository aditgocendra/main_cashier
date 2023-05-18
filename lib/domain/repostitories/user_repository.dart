import 'package:main_cashier/domain/entity/user_entity.dart';

abstract class UserRepository {
  Future<int> createUser(UserEntity userEntity);

  Future updateUser({
    required String uid,
    required String newUsername,
    required int newRole,
  });

  Future<UserEntity> selectUser(String idUser);

  Future changePasswordUser({
    required String uid,
    required String pass,
  });

  Future<List<UserViewEntity>> searchUser(String keyword);

  Future<int> deleteUser(String uid);

  Future<List<UserViewEntity>> getViewUser({
    required int limit,
    required int offset,
  });

  Future<int?> getTotalUser();

  Future<UserEntity> getUserWithUsername(String username);
}
