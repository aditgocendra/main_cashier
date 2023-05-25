import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/entity/user_entity.dart';
import 'package:main_cashier/domain/repostitories/user_repository.dart';

class GetViewUser implements Usecase<List<UserViewEntity>, ParamGetViewUser> {
  final UserRepository repository;

  GetViewUser({
    required this.repository,
  });

  @override
  Future<List<UserViewEntity>> call(ParamGetViewUser params) async {
    return await repository.getViewUser(
      limit: params.limit,
      offset: params.offset,
    );
  }
}

class ParamGetViewUser {
  int limit;
  int offset;

  ParamGetViewUser({
    required this.limit,
    required this.offset,
  });
}
