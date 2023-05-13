import 'package:main_cashier/core/error/exception.dart';
import 'package:main_cashier/data/datasource/local/login_info_local_datasource.dart';
import 'package:main_cashier/domain/repostitories/login_info_repository.dart';

class LoginInfoRepositoryImpl implements LoginInfoRepository {
  final LoginInfoDataLocalSource loginInfoDataLocalSource;

  LoginInfoRepositoryImpl({
    required this.loginInfoDataLocalSource,
  });

  @override
  Future createUserLoginInfo(String uuid) async {
    try {
      await loginInfoDataLocalSource.create(uuid);
    } catch (e) {
      throw DatabaseDriftException("Fail create login info data user");
    }
  }

  @override
  Future deleteUserLoginInfo(String uuid) async {
    try {
      await loginInfoDataLocalSource.delete(uuid);
    } catch (e) {
      throw DatabaseDriftException("Fail delete user login info");
    }
  }

  @override
  Future<String?> getUserLoginInfo() async {
    try {
      return await loginInfoDataLocalSource.get();
    } catch (e) {
      throw DatabaseDriftException("Fail get user login");
    }
  }
}
