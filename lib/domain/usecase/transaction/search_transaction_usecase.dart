import '../../../core/usecase/usecase.dart';
import '../../entity/transaction_entity.dart';
import '../../repostitories/transaction_repository.dart';

class SearchTransaction implements Usecase<List<TransactionEntity>, String> {
  final TransactionRepository repository;

  SearchTransaction({
    required this.repository,
  });

  @override
  Future<List<TransactionEntity>> call(String params) async {
    return await repository.searchTransaction(params);
  }
}
