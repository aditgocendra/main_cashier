import 'package:drift/drift.dart';

import 'drift/drift_database.dart';
import '../../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<int> create(UserModel userModel);

  Future<List<UserViewModel>> getView({
    required int limit,
    required int offset,
  });

  Future update({
    required String uid,
    required String newUsername,
    required int newRole,
  });

  Future changePassword({
    required String uid,
    required String newPassword,
  });

  Future<int> delete(String id);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final DatabaseApp databaseApp;

  UserLocalDataSourceImpl({
    required this.databaseApp,
  });

  @override
  Future<int> create(UserModel userModel) async {
    return await databaseApp.into(databaseApp.userTable).insert(
          UserTableCompanion.insert(
            username: userModel.username,
            password: userModel.password,
            roleId: userModel.roleId,
          ),
        );
  }

  @override
  Future<List<UserViewModel>> getView({
    required int limit,
    required int offset,
  }) async {
    final result = await (databaseApp.select(databaseApp.userView)
          ..limit(
            limit,
            offset: offset,
          ))
        .get();

    return UserViewModel.fromTableList(result);
  }

  @override
  Future<int> delete(String id) async {
    return await (databaseApp.delete(databaseApp.userTable)
          ..where(
            (tbl) => tbl.id.equals(id),
          ))
        .go();
  }

  @override
  Future update({
    required String uid,
    required String newUsername,
    required int newRole,
  }) async {
    (databaseApp.update(databaseApp.userTable)
      ..where((tbl) => tbl.id.equals(uid))
      ..write(
        UserTableCompanion(
          username: Value(newUsername),
          roleId: Value(newRole),
        ),
      ));
  }

  @override
  Future changePassword({
    required String uid,
    required String newPassword,
  }) async {
    (databaseApp.update(databaseApp.userTable)
      ..where((tbl) => tbl.id.equals(uid))
      ..write(
        UserTableCompanion(
          password: Value(newPassword),
        ),
      ));
  }
}
