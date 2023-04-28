import 'package:main_cashier/data/datasource/local/drift/drift_database.dart';
import 'package:main_cashier/domain/entity/product_transaction_entity.dart';

class ProductTransactionModel extends ProductTransactionEntity {
  ProductTransactionModel({
    required super.id,
    required super.name,
    required super.capitalPrice,
    required super.sellPrice,
    required super.qty,
    required super.total,
    required super.idTransaction,
  });
}

class ProductTransactionViewModel extends ProductTransactionViewEntity {
  ProductTransactionViewModel({
    required super.invoice,
    required super.name,
    required super.capitalPrice,
    required super.sellPrice,
    required super.qty,
    required super.total,
    required super.dateTransaction,
  });

  factory ProductTransactionViewModel.fromTable(
    ProductTransactionViewData data,
  ) {
    return ProductTransactionViewModel(
      invoice: data.no,
      name: data.name,
      capitalPrice: data.capitalPrice,
      sellPrice: data.sellPrice,
      qty: data.qty,
      total: data.total,
      dateTransaction: data.dateTransaction,
    );
  }

  static List<ProductTransactionViewModel> fromTableList(
    List<ProductTransactionViewData> data,
  ) {
    if (data.isEmpty) return [];
    return data
        .map((val) => ProductTransactionViewModel.fromTable(val))
        .toList();
  }
}
