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
    required super.code,
    required super.name,
    required super.sellPrice,
    required super.qty,
    required super.total,
  });

  factory DetailTransactionViewModel.fromTable(DetailTransactionViewData data) {
    return DetailTransactionViewModel(
      code: data.codeProduct,
      name: data.name,
      sellPrice: data.sellPrice,
      qty: data.qty,
      total: data.total,
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
