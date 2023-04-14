import 'package:intl/intl.dart';

class FormatUtility {
  static String currencyRp(int number) {
    return NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp. ',
      decimalDigits: 0,
    ).format(number);
  }

  static String dMMMyFormat(DateTime dateTime) {
    return DateFormat('d MMM y', 'id').format(
      dateTime,
    );
  }

  static String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
