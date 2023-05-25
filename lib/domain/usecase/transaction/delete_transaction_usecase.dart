import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/repostitories/transaction_repository.dart';

class DeleteTransaction extends Usecase<dynamic, int> {
  final TransactionRepository repository;

  DeleteTransaction({
    required this.repository,
  });

  @override
  Future call(int params) async {
    return await repository.deleteTransaction(params);
  }
}
