import 'package:drift/drift.dart';
import 'package:main_cashier/data/models/counter_transaction_model.dart';

import 'package:main_cashier/data/models/product_transaction_model.dart';

import 'drift/drift_database.dart';
import '../../models/transaction_model.dart';

abstract class TransactionLocalDataSource {
  Future create({
    required String no,
    required int totalPay,
    required List<ProductTransactionModel> list,
  });

  Future<List<TransactionModel>> getAll({
    required int limit,
    required int offset,
  });

  Future<List<TransactionModel>> getTransactionWithRangeDate(
    List<DateTime> dateRange,
  );

  Future<CounterTransactionModel> getCounterTransaction();

  Future<List<TransactionModel>> search(
    String keyword,
  );

  Future<bool> updateCounterTransaction(
    CounterTransactionModel counterTransactionModel,
  );

  Future<List<ProductTransactionViewModel>> getDetailTransaction(
    int idTransaction,
  );

  Future<List<ProductTransactionViewModel>> getViewDetailTransactions(
    List<DateTime> rangeDate,
  );

  Future<int?> getOmzetWithRange(List<DateTime> dateRange);

  Future<int> getProfitWithRange(List<DateTime> dateRange);

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
    required List<ProductTransactionModel> list,
  }) async {
    final List<ProductTransactionTableCompanion> listProductInsert = [];

    return await databaseApp.transaction(() async {
      // Create transaction
      final result =
          await databaseApp.into(databaseApp.transactionTable).insertReturning(
                TransactionTableCompanion.insert(
                  no: no,
                  totalPay: totalPay,
                ),
              );

      // Create detail transaction
      for (var element in list) {
        listProductInsert.add(ProductTransactionTableCompanion.insert(
          name: element.name,
          capitalPrice: element.capitalPrice,
          sellPrice: element.sellPrice,
          qty: element.qty,
          total: element.total,
          idTransaction: Value(result.id),
        ));
      }

      // Insert all data product checkout
      await databaseApp.batch((batch) {
        batch.insertAll(databaseApp.productTransactionTable, listProductInsert);
      });

      // Increment total transaction in CounterTransactionTable
      await databaseApp.customStatement(
        "UPDATE 'counter_transaction_table' SET total_transaction = total_transaction + 1 WHERE id = 1",
      );

      // Update table sold & stock product
      for (var element in list) {
        await databaseApp.customStatement(
          "UPDATE 'product_table' SET stock = stock - ${element.qty}, sold = sold + ${element.qty} WHERE name = '${element.name}'",
        );
      }
    });
  }

  @override
  Future delete(int idTransaction) async {
    return databaseApp.transaction(() async {
      // Delete detail transaction
      await (databaseApp.delete(databaseApp.productTransactionTable)
            ..where((tbl) => tbl.idTransaction.equals(idTransaction)))
          .go();

      // Delete transaction
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
  Future<List<TransactionModel>> getTransactionWithRangeDate(
    List<DateTime> dateRange,
  ) async {
    final result = await (databaseApp.select(databaseApp.transactionTable)
          ..where(
            (tbl) => tbl.dateTransaction.isBetweenValues(
              dateRange[0],
              dateRange[1],
            ),
          ))
        .get();

    return TransactionModel.fromTableList(result);
  }

  @override
  Future<List<TransactionModel>> search(String keyword) async {
    final result = await (databaseApp.select(databaseApp.transactionTable)
          ..where((tbl) => tbl.no.like('%$keyword%')))
        .get();
    return TransactionModel.fromTableList(result);
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

  @override
  Future<List<ProductTransactionViewModel>> getViewDetailTransactions(
    List<DateTime> rangeDate,
  ) async {
    final result = await (databaseApp.select(
      databaseApp.productTransactionView,
    )..where(
            (tbl) => tbl.dateTransaction.isBetweenValues(
              rangeDate[0],
              rangeDate[1],
            ),
          ))
        .get();

    return ProductTransactionViewModel.fromTableList(result);
  }

  @override
  Future<int?> getOmzetWithRange(List<DateTime> dateRange) async {
    final omzet = databaseApp.productTransactionView.total.sum();

    final query = (databaseApp.selectOnly(databaseApp.productTransactionView)
      ..where(databaseApp.productTransactionView.dateTransaction
          .isBetweenValues(dateRange[0], dateRange[1])))
      ..addColumns(
        [omzet],
      );

    return await query.map((p0) => p0.read(omzet)).getSingle();
  }

  @override
  Future<int> getProfitWithRange(List<DateTime> dateRange) async {
    final result = await (databaseApp.select(databaseApp.productTransactionView)
          ..where(
            (tbl) => tbl.dateTransaction.isBetweenValues(
              dateRange[0],
              dateRange[1],
            ),
          ))
        .get();

    List<int> profit = [];

    for (var element in result) {
      profit.add(element.total - (element.capitalPrice * element.qty));
    }
    return profit.reduce((value, element) => value + element);
  }

  @override
  Future<List<ProductTransactionViewModel>> getDetailTransaction(
    int idTransaction,
  ) async {
    final result = await (databaseApp.select(databaseApp.productTransactionView)
          ..where((tbl) => tbl.id.equals(idTransaction)))
        .get();

    return ProductTransactionViewModel.fromTableList(result);
  }
}
