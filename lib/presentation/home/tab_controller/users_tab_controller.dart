import 'package:flutter/material.dart';
import '../../../domain/entity/user_entity.dart';
import '../../../domain/usecase/user/change_pass_user_usecase.dart';
import '../../../domain/usecase/user/search_user_usecase.dart';
import '../../../core/usecase/usecase.dart';
import '../../../domain/entity/role_entity.dart';

import '../../../domain/usecase/role/get_role_usecase.dart';

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

  bool _isSearch = false;
  bool get isSearch => _isSearch;

  // Role Usecase
  final GetRole getRole;

  // User usecase
  final GetViewUser getViewUser;
  final CreateUser createUser;
  final DeleteUser deleteUser;
  final UpdateUser updateUser;
  final ChangePassword changePassword;
  final SearchUser searchUser;

  UsersTabController({
    required this.getRole,
    required this.getViewUser,
    required this.createUser,
    required this.deleteUser,
    required this.updateUser,
    required this.changePassword,
    required this.searchUser,
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

  void searchDataUser(String keyword) async {
    await searchUser.call(keyword).then((value) {
      if (value.isNotEmpty) {
        _listUser = value;
        tooggleIsSearch();
        notifyListeners();
      }
    });
  }

  void changeRoleUserSelection(RoleEntity role) => _selectionRole = role;
  // End User ------------------------------------------------------------------

  void tooggleIsSearch() => _isSearch = isSearch ? false : true;

  void updateRowPage(int newRowPage) {
    _rowPage = newRowPage;
    _offsetRowPage = 0;
    _activeRowPage = 1;
    setDataUser();
  }

  void nextPage() {
    if (isSearch) {
      return;
    }

    _offsetRowPage = offsetRowPage + rowPage;
    _activeRowPage += 1;
    setDataUser();
  }

  void backPage() {
    if (isSearch) return;
    if (offsetRowPage <= 0) {
      return;
    }

    _offsetRowPage = offsetRowPage - rowPage;
    _activeRowPage -= 1;
    setDataUser();
  }
}
