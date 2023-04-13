import 'package:main_cashier/data/datasource/local/drift/drift_database.dart';
import 'package:main_cashier/domain/entity/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  TransactionModel({
    required super.id,
    required super.numInvoice,
    required super.totalPay,
    required super.dateTransaction,
  });

  TransactionTableData toTable(TransactionModel transactionModel) {
    return TransactionTableData(
      id: transactionModel.id,
      no: transactionModel.numInvoice,
      totalPay: transactionModel.totalPay,
      dateTransaction: transactionModel.dateTransaction,
    );
  }

  factory TransactionModel.fromTable(TransactionTableData data) {
    return TransactionModel(
      id: data.id,
      numInvoice: data.no,
      dateTransaction: data.dateTransaction,
      totalPay: data.totalPay,
    );
  }

  static List<TransactionModel> fromTableList(List<TransactionTableData> data) {
    if (data.isEmpty) return [];
    return data.map((val) => TransactionModel.fromTable(val)).toList();
  }
}
