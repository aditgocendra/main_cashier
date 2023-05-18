import 'package:flutter/material.dart';
import 'package:main_cashier/domain/entity/user_entity.dart';
import 'package:main_cashier/domain/usecase/login_info/get_login_info_usecase.dart';
import 'package:main_cashier/domain/usecase/user/select_user_usecase.dart';

import 'core/usecase/usecase.dart';

class AuthState with ChangeNotifier {
  bool? isLoggedIn;
  UserEntity? userEntity;

  final GetLoginInfo getLoginInfo;
  final SelectUser selectUser;

  AuthState({
    required this.getLoginInfo,
    required this.selectUser,
  }) {
    setUserLoggedIn();
  }

  void setUserLoggedIn() async {
    await getLoginInfo.call(NoParans()).then((value) async {
      if (value != null) {
        isLoggedIn = true;
        setUser(value);
      } else {
        isLoggedIn = false;
      }

      notifyListeners();
    });
  }

  void setUser(String userId) async {
    await selectUser.call(userId).then((value) {
      userEntity = value;
      notifyListeners();
    });
  }
}
