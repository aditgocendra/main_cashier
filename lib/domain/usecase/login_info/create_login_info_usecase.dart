import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/repostitories/login_info_repository.dart';

class CreateLoginInfo implements Usecase<dynamic, String> {
  final LoginInfoRepository repository;

  CreateLoginInfo({required this.repository});

  @override
  Future call(String params) async {
    await repository.createUserLoginInfo(params);
  }
}
