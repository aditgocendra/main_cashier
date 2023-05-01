import 'package:main_cashier/data/models/product_transaction_model.dart';
import 'package:main_cashier/domain/entity/product_transaction_entity.dart';

import '../../core/error/exception.dart';

import '../../domain/entity/counter_transaction_entity.dart';
import '../../domain/entity/transaction_entity.dart';
import '../../domain/repostitories/transaction_repository.dart';

import '../models/counter_transaction_model.dart';

import '../datasource/local/transaction_local_datasource.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionLocalDataSource transactionLocalDataSource;

  TransactionRepositoryImpl({
    required this.transactionLocalDataSource,
  });

  @override
  Future createTransaction({
    required String no,
    required int totalPay,
    required List<ProductTransactionEntity> list,
  }) async {
    final List<ProductTransactionModel> listModel = [];

    for (var element in list) {
      listModel.add(ProductTransactionModel(
        id: element.id,
        qty: element.qty,
        total: element.total,
        capitalPrice: element.capitalPrice,
        sellPrice: element.sellPrice,
        name: element.name,
        idTransaction: 0,
      ));
    }

    try {
      return await transactionLocalDataSource.create(
        no: no,
        totalPay: totalPay,
        list: listModel,
      );
    } catch (_) {
      throw DatabaseDriftException("Create transaction fail");
    }
  }

  @override
  Future deleteTransaction(int id) async {
    try {
      return await transactionLocalDataSource.delete(id);
    } catch (_) {
      throw DatabaseDriftException("Delte transaction fail");
    }
  }

  @override
  Future<List<TransactionEntity>> getAllTransaction({
    required int limit,
    required int offset,
  }) async {
    try {
      return await transactionLocalDataSource.getAll(
        limit: limit,
        offset: offset,
      );
    } catch (_) {
      throw DatabaseDriftException("Fail get all data");
    }
  }

  @override
  Future<List<ProductTransactionViewEntity>> getDetailTransaction(
    int idTransaction,
  ) async {
    try {
      return await transactionLocalDataSource.getDetailTransaction(
        idTransaction,
      );
    } catch (e) {
      throw DatabaseDriftException("Fail get detail transaction");
    }
  }

  @override
  Future<List<TransactionEntity>> getTransactionWithRangeDate(
    List<DateTime> rangeDate,
  ) async {
    try {
      return await transactionLocalDataSource.getTransactionWithRangeDate(
        rangeDate,
      );
    } catch (_) {
      throw DatabaseDriftException("Fail get transaction with range");
    }
  }

  @override
  Future<List<TransactionEntity>> searchTransaction(String keyword) async {
    try {
      return await transactionLocalDataSource.search(keyword);
    } catch (_) {
      throw DatabaseDriftException("Fail search transaction");
    }
  }

  @override
  Future<CounterTransactionEntity> getCounterTransaction() async {
    try {
      return await transactionLocalDataSource.getCounterTransaction();
    } catch (_) {
      throw DatabaseDriftException("Fail get counter transaction");
    }
  }

  @override
  Future<bool> updateCounterTransaction(
      CounterTransactionEntity counterTransactionEntity) async {
    try {
      return await transactionLocalDataSource
          .updateCounterTransaction(CounterTransactionModel(
        id: counterTransactionEntity.id,
        totalTransaction: counterTransactionEntity.totalTransaction,
        dateTime: counterTransactionEntity.dateTime,
      ));
    } catch (_) {
      throw DatabaseDriftException("Fail update counter transaction");
    }
  }

  @override
  Future<List<ProductTransactionViewEntity>> getReportTransactions(
    List<DateTime> rangeDate,
  ) async {
    try {
      return await transactionLocalDataSource.getViewDetailTransactions(
        rangeDate,
      );
    } catch (e) {
      throw DatabaseDriftException("Fail get report transactions");
    }
  }

  @override
  Future<int?> getOmzetWithRange(List<DateTime> rangeDate) async {
    try {
      return await transactionLocalDataSource.getOmzetWithRange(rangeDate);
    } catch (_) {
      throw DatabaseDriftException("Fail get omzet");
    }
  }

  @override
  Future<int> getProfitWithRange(List<DateTime> rangeDate) async {
    try {
      return await transactionLocalDataSource.getProfitWithRange(rangeDate);
    } catch (_) {
      throw DatabaseDriftException("Fail get profit");
    }
  }

  @override
  Future<int?> getTotalTransaction() async {
    try {
      return await transactionLocalDataSource.getTotal();
    } catch (_) {
      throw DatabaseDriftException("Fail get total transaction");
    }
  }
}
