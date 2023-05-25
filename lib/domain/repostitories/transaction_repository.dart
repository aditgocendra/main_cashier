import '../entity/counter_transaction_entity.dart';
import '../entity/transaction_entity.dart';
import '../entity/product_transaction_entity.dart';

abstract class TransactionRepository {
  Future createTransaction({
    required String no,
    required int totalPay,
    required List<ProductTransactionEntity> list,
  });

  Future<List<TransactionEntity>> getAllTransaction({
    required int limit,
    required int offset,
  });

  Future<List<ProductTransactionViewEntity>> getDetailTransaction(
    int idTransaction,
  );

  Future<List<TransactionEntity>> getTransactionWithRangeDate(
    List<DateTime> rangeDate,
  );

  Future<List<ProductTransactionViewEntity>> getReportTransactions(
    List<DateTime> rangeDate,
  );

  Future<int?> getOmzetWithRange(List<DateTime> rangeDate);

  Future<int> getProfitWithRange(List<DateTime> rangeDate);

  Future<int?> getTotalTransaction();

  Future<List<TransactionEntity>> searchTransaction(String keyword);

  Future deleteTransaction(int id);

  Future<CounterTransactionEntity> getCounterTransaction();

  Future<bool> updateCounterTransaction(
    CounterTransactionEntity counterTransactionEntity,
  );
}
