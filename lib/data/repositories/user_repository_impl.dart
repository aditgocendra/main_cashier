import '../../core/error/exception.dart';
import '../datasource/local/user_local_datasource.dart';
import '../models/user_model.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repostitories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource userLocalDataSource;

  UserRepositoryImpl({
    required this.userLocalDataSource,
  });

  @override
  Future<UserViewEntity> createUser(UserEntity userEntity) async {
    try {
      final r = await userLocalDataSource.userIsExist(userEntity.username);

      if (r) throw DatabaseDriftException("Username is exist");

      await userLocalDataSource.create(
        UserModel(
          uid: userEntity.uid,
          username: userEntity.username,
          password: userEntity.password,
          roleId: userEntity.roleId,
          createdAt: userEntity.createdAt,
        ),
      );

      return await userLocalDataSource.selectView(userEntity.username);
    } catch (e) {
      throw DatabaseDriftException("Insert data user fail");
    }
  }

  @override
  Future<int> deleteUser(String uid) async {
    try {
      return await userLocalDataSource.delete(uid);
    } catch (e) {
      throw DatabaseDriftException("Delete data user fail");
    }
  }

  @override
  Future<List<UserViewEntity>> getViewUser({
    required int limit,
    required int offset,
  }) async {
    try {
      return await userLocalDataSource.getView(
        limit: limit,
        offset: offset,
      );
    } catch (e) {
      throw DatabaseDriftException("Get all data user fail");
    }
  }

  @override
  Future updateUser({
    required String uid,
    required String newUsername,
    required int newRole,
  }) async {
    try {
      return await userLocalDataSource.update(
        uid: uid,
        newUsername: newUsername,
        newRole: newRole,
      );
    } catch (e) {
      throw DatabaseDriftException("Update data user fail");
    }
  }

  @override
  Future changePasswordUser({required String uid, required String pass}) async {
    try {
      return await userLocalDataSource.changePassword(
        uid: uid,
        newPassword: pass,
      );
    } catch (e) {
      throw DatabaseDriftException("Change password user fail");
    }
  }

  @override
  Future<List<UserViewEntity>> searchUser(String keyword) async {
    try {
      return await userLocalDataSource.search(keyword);
    } catch (e) {
      throw DatabaseDriftException("Search data user fail");
    }
  }

  @override
  Future<UserEntity> getUserWithUsername(String username) async {
    try {
      return await userLocalDataSource.getUserWithUsername(username);
    } catch (e) {
      throw DatabaseDriftException("Get user with username fail");
    }
  }

  @override
  Future<int?> getTotalUser() async {
    try {
      return await userLocalDataSource.getTotal();
    } catch (e) {
      throw DatabaseDriftException("Get user fail");
    }
  }

  @override
  Future<UserEntity> selectUser(String idUser) async {
    try {
      return await userLocalDataSource.select(idUser);
    } catch (e) {
      throw DatabaseDriftException("Select user fail");
    }
  }
}
