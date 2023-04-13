import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/entity/counter_transaction_entity.dart';
import 'package:main_cashier/domain/repostitories/transaction_repository.dart';

class GetCounterTransaction
    implements Usecase<CounterTransactionEntity, NoParans> {
  final TransactionRepository repository;

  GetCounterTransaction({
    required this.repository,
  });

  @override
  Future<CounterTransactionEntity> call(_) async {
    return await repository.getCounterTransaction();
  }
}
