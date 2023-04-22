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
  String code;
  String name;
  int sellPrice;
  int qty;
  int total;

  DetailTransactionViewEntity({
    required this.code,
    required this.name,
    required this.sellPrice,
    required this.qty,
    required this.total,
  });

  String getIndex(int index) {
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
}
