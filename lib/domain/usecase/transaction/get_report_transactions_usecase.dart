import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/entity/detail_transaction_entity.dart';
import 'package:main_cashier/domain/repostitories/transaction_repository.dart';

class GetReportTransactions
    implements Usecase<List<DetailTransactionViewEntity>, List<DateTime>> {
  final TransactionRepository repository;

  GetReportTransactions({
    required this.repository,
  });
  @override
  Future<List<DetailTransactionViewEntity>> call(
    List<DateTime> params,
  ) async {
    return await repository.getReportTransactions(params);
  }
}
