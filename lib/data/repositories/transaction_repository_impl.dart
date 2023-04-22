import '../../core/error/exception.dart';

import '../../domain/entity/counter_transaction_entity.dart';
import '../../domain/entity/transaction_entity.dart';
import '../../domain/repostitories/transaction_repository.dart';
import '../../domain/entity/detail_transaction_entity.dart';

import '../models/counter_transaction_model.dart';
import '../models/detail_transaction_model.dart';

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
    required List<DetailTransactionEntity> list,
  }) async {
    final List<DetailTransactionModel> listModel = [];

    for (var element in list) {
      listModel.add(DetailTransactionModel(
        id: element.id,
        qty: element.qty,
        total: element.total,
        idProduct: element.idProduct,
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
  Future<List<DetailTransactionViewEntity>> getDetailTransaction(
    int idTransaction,
  ) async {
    try {
      return await transactionLocalDataSource.getDetailTransaction(
        idTransaction,
      );
    } catch (_) {
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
}
