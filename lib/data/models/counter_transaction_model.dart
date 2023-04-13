import 'package:main_cashier/data/datasource/local/drift/drift_database.dart';
import 'package:main_cashier/domain/entity/counter_transaction_entity.dart';

class CounterTransactionModel extends CounterTransactionEntity {
  CounterTransactionModel({
    required super.id,
    required super.totalTransaction,
    required super.dateTime,
  });

  CounterTransactionTableData toTable(
      CounterTransactionModel counterTransactionModel) {
    return CounterTransactionTableData(
      id: counterTransactionModel.id,
      totalTransaction: counterTransactionModel.totalTransaction,
      day: counterTransactionModel.dateTime,
    );
  }

  factory CounterTransactionModel.fromTable(CounterTransactionTableData data) {
    return CounterTransactionModel(
      id: data.id,
      totalTransaction: data.totalTransaction,
      dateTime: data.day,
    );
  }
}
