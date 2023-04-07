import 'package:flutter/material.dart';
import 'package:main_cashier/domain/entity/user_entity.dart';
import 'package:main_cashier/domain/usecase/user/change_pass_user_usecase.dart';
import '../../../core/usecase/usecase.dart';
import '../../../domain/entity/role_entity.dart';
import '../../../domain/usecase/role/create_role_usecase.dart';
import '../../../domain/usecase/role/delete_role_usecase.dart';
import '../../../domain/usecase/role/get_role_usecase.dart';
import '../../../domain/usecase/role/update_role_usecase.dart';
import '../../../domain/usecase/user/create_user_usecase.dart';
import '../../../domain/usecase/user/delete_user_usecase.dart';
import '../../../domain/usecase/user/get_view_user_usecase.dart';
import '../../../domain/usecase/user/update_user_usecase.dart';

class UsersTabController extends ChangeNotifier {
  List<RoleEntity> _listRole = [];
  List<RoleEntity> get listRole => _listRole;

  List<UserViewEntity> _listUser = [];
  List<UserViewEntity> get listUser => _listUser;

  RoleEntity? _selectionRole;
  RoleEntity? get selectionRole => _selectionRole;

  int _rowPage = 10;
  int get rowPage => _rowPage;

  int _offsetRowPage = 0;
  int get offsetRowPage => _offsetRowPage;

  int _activeRowPage = 1;
  int get activeRowPage => _activeRowPage;

  String _errMessageDialog = "";
  String get errMessageDialog => _errMessageDialog;

  // Role Usecase
  final GetRole getRole;
  final CreateRole createRole;
  final DeleteRole deleteRole;
  final UpdateRole updateRole;

  // User usecase
  final GetViewUser getViewUser;
  final CreateUser createUser;
  final DeleteUser deleteUser;
  final UpdateUser updateUser;
  final ChangePassword changePassword;

  UsersTabController({
    required this.getRole,
    required this.createRole,
    required this.deleteRole,
    required this.updateRole,
    required this.getViewUser,
    required this.createUser,
    required this.deleteUser,
    required this.updateUser,
    required this.changePassword,
  });

  // Role ----------------------------------------------------------------------
  void setDataRole() async {
    await getRole.call(NoParans()).then((value) {
      _listRole = value;
      notifyListeners();
    }).catchError((e) {
      _errMessageDialog = e.toString();
      notifyListeners();
    });
  }

  void addRole(String name) async {
    await createRole.call(name).then((value) {
      _listRole.add(value);
      notifyListeners();
    }).catchError((e) {
      _errMessageDialog = e.toString();
      notifyListeners();
    });
  }

  void editRole(RoleEntity roleEntity) async {
    await updateRole.call(roleEntity).then((value) {
      final index = listRole.indexWhere(
        (element) => element.id == roleEntity.id,
      );

      _listRole[index] = roleEntity;

      notifyListeners();
    }).catchError((e) {
      _errMessageDialog = e.toString();
      notifyListeners();
    });
  }

  void removeRole(int id) async {
    await deleteRole.call(id).then((rowsAffected) {
      if (rowsAffected < 1) {
        return;
      }

      _listRole.removeWhere((element) => element.id == id);
      notifyListeners();
    }).catchError((e) {
      _errMessageDialog = e.toString();
      notifyListeners();
    });
  }

  // End Role ------------------------------------------------------------------

  // User ----------------------------------------------------------------------
  void setDataUser() async {
    ParamGetViewUser params = ParamGetViewUser(
      limit: rowPage,
      offset: offsetRowPage,
    );

    await getViewUser.call(params).then((value) {
      _listUser = value;
      notifyListeners();
    });
  }

  void addUser(UserEntity userEntity) async {
    await createUser.call(userEntity).then((value) {}).catchError((e) {
      _errMessageDialog = e.toString();
      notifyListeners();
    });
  }

  void editUser(String uid, String username, int role) async {
    final params = ParamUpdateUser(uid: uid, username: username, role: role);

    await updateUser.call(params).then((_) {
      final index = listUser.indexWhere((element) => element.uid == uid);

      _listUser[index].username = username;
      _listUser[index].roleName =
          listRole.where((element) => element.id == role).first.name;

      notifyListeners();
    }).catchError((e) {
      _errMessageDialog = e.toString();
      notifyListeners();
    });
  }

  void changePasswordUser(String uid, String pass) async {
    final params = ParamChangePassword(
      uid: uid,
      pass: pass,
    );

    await changePassword.call(params).onError((error, stackTrace) {
      _errMessageDialog = error.toString();
      print("test");
      notifyListeners();
    });
  }

  void removeUser(String uid) async {
    await deleteUser.call(uid).then((value) {
      _listUser.removeWhere((element) => element.uid == uid);
      notifyListeners();
    }).catchError((e) {
      _errMessageDialog = e.toString();
      notifyListeners();
    });
  }

  void changeRoleUserSelection(RoleEntity role) => _selectionRole = role;
  // End User ------------------------------------------------------------------
}
