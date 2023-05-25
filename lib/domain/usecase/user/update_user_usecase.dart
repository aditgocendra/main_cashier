import '../../../core/usecase/usecase.dart';
import '../../repostitories/user_repository.dart';

class UpdateUser implements Usecase<dynamic, ParamUpdateUser> {
  final UserRepository repository;

  UpdateUser({
    required this.repository,
  });

  @override
  Future call(ParamUpdateUser params) async {
    return await repository.updateUser(
      uid: params.uid,
      newUsername: params.username,
      newRole: params.role,
    );
  }
}

class ParamUpdateUser {
  String uid;
  String username;
  int role;

  ParamUpdateUser({
    required this.uid,
    required this.username,
    required this.role,
  });
}
