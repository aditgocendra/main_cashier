import 'package:flutter/material.dart';
import '../../domain/usecase/login_info/create_login_info_usecase.dart';
import '../../domain/usecase/user/get_user_with_username_usecase.dart';

class SignInController extends ChangeNotifier {
  final GetUserWithUsername getUserWithUsername;
  final CreateLoginInfo createLoginInfo;

  SignInController({
    required this.getUserWithUsername,
    required this.createLoginInfo,
  });

  void signIn({
    required String username,
    required String pass,
    required VoidCallback callbackSuccess,
    required VoidCallback callbackFail,
  }) async {
    await getUserWithUsername.call(username).then((value) async {
      if (value.password != pass) {
        return;
      }

      await createLoginInfo.call(value.uid).then(
            (value) => callbackSuccess.call(),
          );
    });
  }
}
