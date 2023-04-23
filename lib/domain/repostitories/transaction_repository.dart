import 'package:main_cashier/domain/entity/counter_transaction_entity.dart';
import 'package:main_cashier/domain/entity/detail_transaction_entity.dart';
import 'package:main_cashier/domain/entity/transaction_entity.dart';

abstract class TransactionRepository {
  Future createTransaction({
    required String no,
    required int totalPay,
    required List<DetailTransactionEntity> list,
  });

  Future<List<TransactionEntity>> getAllTransaction({
    required int limit,
    required int offset,
  });

  Future<List<DetailTransactionViewEntity>> getDetailTransaction(
    int idTransaction,
  );

  Future<List<TransactionEntity>> getTransactionWithRangeDate(
    List<DateTime> rangeDate,
  );

  Future<List<DetailTransactionViewEntity>> getReportTransactions(
    List<DateTime> rangeDate,
  );

  Future<int?> getOmzetWithRange(List<DateTime> rangeDate);

  Future<int> getProfitWithRange(List<DateTime> rangeDate);

  Future<List<TransactionEntity>> searchTransaction(String keyword);

  Future deleteTransaction(int id);

  Future<CounterTransactionEntity> getCounterTransaction();

  Future<bool> updateCounterTransaction(
    CounterTransactionEntity counterTransactionEntity,
  );
}
