import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/entity/transaction_entity.dart';
import 'package:main_cashier/domain/repostitories/transaction_repository.dart';

class GetAllTransaction
    implements Usecase<List<TransactionEntity>, ParamGetAllTransaction> {
  final TransactionRepository repository;

  GetAllTransaction({
    required this.repository,
  });

  @override
  Future<List<TransactionEntity>> call(ParamGetAllTransaction params) async {
    return await repository.getAllTransaction(
      limit: params.limit,
      offset: params.offset,
    );
  }
}

class ParamGetAllTransaction {
  int limit;
  int offset;

  ParamGetAllTransaction({
    required this.limit,
    required this.offset,
  });
}
