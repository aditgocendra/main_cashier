import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/repostitories/transaction_repository.dart';

class GetProfitWithRange implements Usecase<int, List<DateTime>> {
  final TransactionRepository repository;

  GetProfitWithRange({
    required this.repository,
  });

  @override
  Future<int> call(List<DateTime> params) async {
    return await repository.getProfitWithRange(params);
  }
}
