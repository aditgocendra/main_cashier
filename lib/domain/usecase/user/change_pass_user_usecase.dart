import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/repostitories/user_repository.dart';

class ChangePassword implements Usecase<dynamic, ParamChangePassword> {
  final UserRepository repository;

  ChangePassword({
    required this.repository,
  });

  @override
  Future call(ParamChangePassword params) async {
    return await repository.changePasswordUser(
      uid: params.uid,
      pass: params.pass,
    );
  }
}

class ParamChangePassword {
  String uid;
  String pass;

  ParamChangePassword({
    required this.uid,
    required this.pass,
  });
}
