import '../../../core/usecase/usecase.dart';
import '../../repostitories/login_info_repository.dart';

class GetLoginInfo implements Usecase<String?, NoParans> {
  final LoginInfoRepository repository;

  GetLoginInfo({
    required this.repository,
  });

  @override
  Future<String?> call(NoParans params) async {
    return await repository.getUserLoginInfo();
  }
}
