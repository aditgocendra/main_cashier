import '../../core/utils/format_utils.dart';

class ProductTransactionEntity {
  int id;
  String name;
  int capitalPrice;
  int sellPrice;
  int qty;
  int total;
  int idTransaction;

  ProductTransactionEntity({
    required this.id,
    required this.name,
    required this.capitalPrice,
    required this.sellPrice,
    required this.qty,
    required this.total,
    required this.idTransaction,
  });
}

class ProductTransactionViewEntity {
  String invoice;
  String name;
  int capitalPrice;
  int sellPrice;
  int qty;
  int total;
  DateTime dateTransaction;

  ProductTransactionViewEntity({
    required this.invoice,
    required this.name,
    required this.capitalPrice,
    required this.sellPrice,
    required this.qty,
    required this.total,
    required this.dateTransaction,
  });

  String getIndexInvoice(int index) {
    switch (index) {
      case 0:
        return name;
      case 1:
        return FormatUtility.currencyRp(sellPrice);
      case 2:
        return '${qty.toString()} Unit';
      case 3:
        return FormatUtility.currencyRp(total);
      default:
        return '';
    }
  }

  String getIndexReport(int index) {
    switch (index) {
      case 0:
        return invoice;
      case 1:
        return name;
      case 2:
        return FormatUtility.currencyRp(capitalPrice);
      case 3:
        return FormatUtility.currencyRp(sellPrice);
      case 4:
        return qty.toString();
      case 5:
        return FormatUtility.currencyRp(total);
      case 6:
        return FormatUtility.dMMMyFormat(dateTransaction);
      default:
        return '';
    }
  }
}
