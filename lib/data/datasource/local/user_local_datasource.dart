import 'package:drift/drift.dart';

import 'drift/drift_database.dart';
import '../../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<int> create(UserModel userModel);

  Future<List<UserViewModel>> getView({
    required int limit,
    required int offset,
  });

  Future<UserModel> select(String userId);

  Future<UserViewModel> selectView(String username);

  Future<bool> userIsExist(String username);

  Future update({
    required String uid,
    required String newUsername,
    required int newRole,
  });

  Future changePassword({
    required String uid,
    required String newPassword,
  });

  Future<int?> getTotal();

  Future<UserModel> getUserWithUsername(String username);

  Future<List<UserViewModel>> search(String keyword);

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
            roleId: Value(userModel.roleId),
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

  @override
  Future<UserModel> getUserWithUsername(String username) async {
    final r = await (databaseApp.select(databaseApp.userTable)
          ..where((tbl) => tbl.username.equals(username)))
        .getSingle();

    return UserModel.fromTable(r);
  }

  @override
  Future<List<UserViewModel>> search(String keyword) async {
    final result = await (databaseApp.select(databaseApp.userView)
          ..where((tbl) => tbl.username.like('%$keyword%')))
        .get();
    return UserViewModel.fromTableList(result);
  }

  @override
  Future<int?> getTotal() async {
    var id = databaseApp.userTable.id.count();
    final query = (databaseApp.selectOnly(databaseApp.userTable))
      ..addColumns([id]);

    return await query.map((p0) => p0.read(id)).getSingle();
  }

  @override
  Future<UserModel> select(String userId) async {
    final r = await (databaseApp.select(databaseApp.userTable)
          ..where((tbl) => tbl.id.equals(userId)))
        .getSingle();

    return UserModel.fromTable(r);
  }

  @override
  Future<bool> userIsExist(String username) async {
    final r = await (databaseApp.select(databaseApp.userTable)
          ..where((tbl) => tbl.username.equals(username)))
        .get();

    return r.isNotEmpty ? true : false;
  }

  @override
  Future<UserViewModel> selectView(String username) async {
    final r = await (databaseApp.select(databaseApp.userView)
          ..where((tbl) => tbl.username.equals(username)))
        .getSingle();

    return UserViewModel.fromTable(r);
  }
}
