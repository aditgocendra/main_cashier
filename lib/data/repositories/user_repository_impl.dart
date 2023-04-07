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
  Future<int> createUser(UserEntity userEntity) async {
    try {
      return await userLocalDataSource.create(
        UserModel(
          uid: userEntity.uid,
          username: userEntity.username,
          password: userEntity.password,
          roleId: userEntity.roleId,
          createdAt: userEntity.createdAt,
        ),
      );
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
}
