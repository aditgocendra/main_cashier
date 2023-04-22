import '../../core/utils/format_utils.dart';

class TransactionEntity {
  int id;
  String numInvoice;
  int totalPay;
  DateTime dateTransaction;

  TransactionEntity({
    required this.id,
    required this.numInvoice,
    required this.totalPay,
    required this.dateTransaction,
  });

  String getIndex(int index) {
    switch (index) {
      case 0:
        return numInvoice;
      case 1:
        return FormatUtility.currencyRp(totalPay);
      case 2:
        return FormatUtility.dMMMyFormat(dateTransaction);

      default:
        return '';
    }
  }
}
