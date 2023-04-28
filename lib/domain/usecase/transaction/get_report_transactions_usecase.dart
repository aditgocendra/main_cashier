import '../../../core/usecase/usecase.dart';
import '../../entity/product_transaction_entity.dart';
import '../../repostitories/transaction_repository.dart';

class GetReportTransactions
    implements Usecase<List<ProductTransactionViewEntity>, List<DateTime>> {
  final TransactionRepository repository;

  GetReportTransactions({
    required this.repository,
  });
  @override
  Future<List<ProductTransactionViewEntity>> call(
    List<DateTime> params,
  ) async {
    return await repository.getReportTransactions(params);
  }
}
