import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/repostitories/transaction_repository.dart';

class GetOmzetWithRange implements Usecase<int?, List<DateTime>> {
  final TransactionRepository repository;

  GetOmzetWithRange({
    required this.repository,
  });

  @override
  Future<int?> call(List<DateTime> params) async {
    return await repository.getOmzetWithRange(params);
  }
}
