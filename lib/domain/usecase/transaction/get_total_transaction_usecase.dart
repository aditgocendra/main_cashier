import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/repostitories/transaction_repository.dart';

class GetTotalTransaction implements Usecase<int?, NoParans> {
  final TransactionRepository repository;

  GetTotalTransaction({
    required this.repository,
  });

  @override
  Future<int?> call(NoParans params) async {
    return await repository.getTotalTransaction();
  }
}
