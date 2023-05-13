abstract class LoginInfoRepository {
  Future createUserLoginInfo(String uuid);

  Future deleteUserLoginInfo(String uuid);

  Future<String?> getUserLoginInfo();
}
