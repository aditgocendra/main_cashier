import 'package:intl/intl.dart';

class FormatUtility {
  static String currencyRp(int number) {
    return NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp. ',
      decimalDigits: 0,
    ).format(number);
  }
}
