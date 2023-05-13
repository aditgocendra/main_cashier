import 'package:flutter/material.dart';
import 'package:main_cashier/domain/usecase/login_info/get_login_info_usecase.dart';

import 'core/usecase/usecase.dart';

class AuthState with ChangeNotifier {
  bool? isLoggedIn;

  final GetLoginInfo getLoginInfo;

  AuthState({
    required this.getLoginInfo,
  }) {
    setUserLoggedIn();
  }

  void setUserLoggedIn() async {
    await getLoginInfo.call(NoParans()).then((value) {
      if (value != null) {
        isLoggedIn = true;
      } else {
        isLoggedIn = false;
      }

      notifyListeners();
    });
  }
}
