import 'package:flutter/material.dart';
import 'package:main_cashier/domain/entity/user_entity.dart';
import 'package:main_cashier/domain/usecase/login_info/get_login_info_usecase.dart';
import 'package:main_cashier/domain/usecase/user/get_user_with_username_usecase.dart';

import 'core/usecase/usecase.dart';

class AuthState with ChangeNotifier {
  bool? isLoggedIn;
  UserEntity? user;

  final GetLoginInfo getLoginInfo;
  final GetUserWithUsername getUserWithUsername;

  AuthState({
    required this.getLoginInfo,
    required this.getUserWithUsername,
  }) {
    setUserLoggedIn();
  }

  void setUserLoggedIn() async {
    await getLoginInfo.call(NoParans()).then((value) async {
      if (value != null) {
        isLoggedIn = true;
      } else {
        isLoggedIn = false;
      }

      notifyListeners();
    });
  }

  void setUser(String username) async {
    await getUserWithUsername.call(username).then((value) {
      user = value;
      notifyListeners();
    });
  }
}
