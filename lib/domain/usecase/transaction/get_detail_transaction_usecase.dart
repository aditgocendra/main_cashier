import '../../../core/usecase/usecase.dart';
import '../../entity/product_transaction_entity.dart';
import '../../repostitories/transaction_repository.dart';

class GetDetailTransaction
    implements Usecase<List<ProductTransactionViewEntity>, int> {
  final TransactionRepository repository;

  GetDetailTransaction({
    required this.repository,
  });

  @override
  Future<List<ProductTransactionViewEntity>> call(int idTransaction) async {
    return await repository.getDetailTransaction(idTransaction);
  }
}
