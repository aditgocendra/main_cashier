import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/entity/detail_transaction_entity.dart';
import 'package:main_cashier/domain/repostitories/transaction_repository.dart';

class GetDetailTransaction
    implements Usecase<List<DetailTransactionViewEntity>, int> {
  final TransactionRepository repository;

  GetDetailTransaction({
    required this.repository,
  });

  @override
  Future<List<DetailTransactionViewEntity>> call(int idTransaction) async {
    return await repository.getDetailTransaction(idTransaction);
  }
}
