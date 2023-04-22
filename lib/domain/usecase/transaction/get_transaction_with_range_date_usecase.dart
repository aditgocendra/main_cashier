import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/entity/transaction_entity.dart';
import 'package:main_cashier/domain/repostitories/transaction_repository.dart';

class GetTransactionWithRangeDate
    implements Usecase<List<TransactionEntity>, List<DateTime>> {
  final TransactionRepository repository;

  GetTransactionWithRangeDate({
    required this.repository,
  });

  @override
  Future<List<TransactionEntity>> call(List<DateTime> rangeDate) async {
    return await repository.getTransactionWithRangeDate(rangeDate);
  }
}
