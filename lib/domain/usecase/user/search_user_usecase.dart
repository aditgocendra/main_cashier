import '../../../core/usecase/usecase.dart';
import '../../entity/user_entity.dart';
import '../../repostitories/user_repository.dart';

class SearchUser implements Usecase<List<UserViewEntity>, String> {
  final UserRepository repository;

  SearchUser({
    required this.repository,
  });

  @override
  Future<List<UserViewEntity>> call(String params) async {
    return await repository.searchUser(params);
  }
}
