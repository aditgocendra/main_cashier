import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/entity/counter_transaction_entity.dart';
import 'package:main_cashier/domain/repostitories/transaction_repository.dart';

class UpdateCounterTransaction
    implements Usecase<bool, CounterTransactionEntity> {
  final TransactionRepository repository;

  UpdateCounterTransaction({
    required this.repository,
  });
  @override
  Future<bool> call(CounterTransactionEntity params) async {
    return await repository.updateCounterTransaction(params);
  }
}
