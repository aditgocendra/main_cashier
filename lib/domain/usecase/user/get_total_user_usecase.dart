import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/repostitories/user_repository.dart';

class GetTotalUser implements Usecase<int?, NoParans> {
  final UserRepository repository;

  GetTotalUser({
    required this.repository,
  });

  @override
  Future<int?> call(NoParans params) async {
    return repository.getTotalUser();
  }
}
