import 'package:main_cashier/data/datasource/local/drift/drift_database.dart';
import 'package:main_cashier/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.uid,
    required super.username,
    required super.password,
    required super.roleId,
    required super.createdAt,
  });

  UserTableData toTable(UserModel user) {
    return UserTableData(
      id: user.uid,
      username: user.username,
      password: user.password,
      createdAt: user.createdAt,
      roleId: user.roleId,
    );
  }

  factory UserModel.fromTable(UserTableData data) {
    return UserModel(
      uid: data.id,
      username: data.username,
      password: data.password,
      createdAt: data.createdAt,
      roleId: data.roleId!,
    );
  }

  static List<UserModel> fromTableList(List<UserTableData> data) {
    if (data.isEmpty) return [];
    return data.map((val) => UserModel.fromTable(val)).toList();
  }
}

class UserViewModel extends UserViewEntity {
  UserViewModel({
    required super.uid,
    required super.username,
    required super.roleName,
  });

  factory UserViewModel.fromTable(UserViewData data) {
    return UserViewModel(
      uid: data.id,
      username: data.username,
      roleName: data.name,
    );
  }

  static List<UserViewModel> fromTableList(List<UserViewData> data) {
    if (data.isEmpty) return [];
    return data.map((val) => UserViewModel.fromTable(val)).toList();
  }
}
