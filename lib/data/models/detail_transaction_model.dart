import 'package:main_cashier/data/datasource/local/drift/drift_database.dart';

import '../../domain/entity/detail_transaction_entity.dart';

class DetailTransactionModel extends DetailTransactionEntity {
  DetailTransactionModel({
    required super.id,
    required super.qty,
    required super.total,
    required super.idProduct,
  });
}

class DetailTransactionViewModel extends DetailTransactionViewEntity {
  DetailTransactionViewModel({
    required super.invoice,
    required super.code,
    required super.name,
    required super.sellPrice,
    required super.qty,
    required super.total,
    required super.capitalPrice,
    required super.dateTransaction,
  });

  factory DetailTransactionViewModel.fromTable(DetailTransactionViewData data) {
    return DetailTransactionViewModel(
      invoice: data.no,
      code: data.codeProduct,
      name: data.name,
      capitalPrice: data.capitalPrice,
      sellPrice: data.sellPrice,
      qty: data.qty,
      total: data.total,
      dateTransaction: data.dateTransaction,
    );
  }

  static List<DetailTransactionViewModel> fromTableList(
    List<DetailTransactionViewData> data,
  ) {
    if (data.isEmpty) return [];
    return data
        .map((val) => DetailTransactionViewModel.fromTable(val))
        .toList();
  }
}
