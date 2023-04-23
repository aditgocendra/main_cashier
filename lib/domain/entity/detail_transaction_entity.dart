import '../../core/utils/format_utils.dart';

class DetailTransactionEntity {
  int id;
  int qty;
  int total;
  String idProduct;

  DetailTransactionEntity({
    required this.id,
    required this.qty,
    required this.total,
    required this.idProduct,
  });
}

class DetailTransactionViewEntity {
  String invoice;
  String code;
  String name;
  int capitalPrice;
  int sellPrice;
  int qty;
  int total;
  DateTime dateTransaction;

  DetailTransactionViewEntity({
    required this.invoice,
    required this.code,
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
