import 'package:main_cashier/data/models/counter_transaction_model.dart';
import 'package:main_cashier/data/models/detail_transaction_model.dart';

import 'drift/drift_database.dart';
import '../../models/transaction_model.dart';

abstract class TransactionLocalDataSource {
  Future create({
    required String no,
    required int totalPay,
    required List<DetailTransactionModel> list,
  });

  Future<List<TransactionModel>> getAll({
    required int limit,
    required int offset,
  });

  Future<CounterTransactionModel> getCounterTransaction();

  Future<bool> updateCounterTransaction(
    CounterTransactionModel counterTransactionModel,
  );

  Future<List<DetailTransactionViewModel>> getDetailTransaction(
    int idTransaction,
  );

  Future delete(int idTransaction);
}

class TransactionLocalDataSourceImpl implements TransactionLocalDataSource {
  final DatabaseApp databaseApp;

  TransactionLocalDataSourceImpl({
    required this.databaseApp,
  });

  @override
  Future create({
    required String no,
    required int totalPay,
    required List<DetailTransactionModel> list,
  }) async {
    final List<DetailTransactionTableCompanion> listProductInsert = [];

    return await databaseApp.transaction(() async {
      // Create transaction
      final result =
          await databaseApp.into(databaseApp.transactionTable).insertReturning(
                TransactionTableCompanion.insert(
                  no: no,
                  totalPay: totalPay,
                ),
              );

      // Create product transaction
      for (var element in list) {
        listProductInsert.add(DetailTransactionTableCompanion.insert(
          qty: element.qty,
          total: element.total,
          codeProduct: element.idProduct,
          idTransaction: result.id,
        ));
      }

      // Insert all data product checkout
      await databaseApp.batch((batch) {
        batch.insertAll(databaseApp.detailTransactionTable, listProductInsert);
      });
    });
  }

  @override
  Future delete(int idTransaction) async {
    return databaseApp.transaction(() async {
      // Delete detail transaction
      await (databaseApp.delete(databaseApp.detailTransactionTable)
            ..where((tbl) => tbl.idTransaction.equals(idTransaction)))
          .go();

      await (databaseApp.delete(databaseApp.transactionTable)
            ..where((tbl) => tbl.id.equals(idTransaction)))
          .go();
    });
  }

  @override
  Future<List<TransactionModel>> getAll({
    required int limit,
    required int offset,
  }) async {
    final result = await (databaseApp.select(databaseApp.transactionTable)
          ..limit(limit, offset: offset))
        .get();

    return TransactionModel.fromTableList(result);
  }

  @override
  Future<List<DetailTransactionViewModel>> getDetailTransaction(
    int idTransaction,
  ) async {
    final result =
        await databaseApp.select(databaseApp.detailTransactionView).get();

    return DetailTransactionViewModel.fromTableList(result);
  }

  @override
  Future<CounterTransactionModel> getCounterTransaction() async {
    final result = await databaseApp
        .select(databaseApp.counterTransactionTable)
        .getSingle();

    return CounterTransactionModel.fromTable(result);
  }

  @override
  Future<bool> updateCounterTransaction(
    CounterTransactionModel counterTransactionModel,
  ) async {
    return await databaseApp
        .update(databaseApp.counterTransactionTable)
        .replace(
          counterTransactionModel.toTable(
            counterTransactionModel,
          ),
        );
  }
}
