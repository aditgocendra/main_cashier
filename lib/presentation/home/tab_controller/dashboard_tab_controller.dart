import 'package:flutter/foundation.dart';
import '../../../domain/usecase/transaction/get_profit_transaction_with_range_usecase.dart';
import '../../../core/usecase/usecase.dart';
import '../../../domain/usecase/category/get_total_category_usecase.dart';
import '../../../domain/usecase/product/get_total_product_usecase.dart';
import '../../../domain/usecase/transaction/get_total_transaction_usecase.dart';

class DashboardTabController extends ChangeNotifier {
  int _totalProduct = 0;
  int get totalProduct => _totalProduct;

  int _totalCategory = 0;
  int get totalCategory => _totalCategory;

  int _totalTransaction = 0;
  int get totalTransaction => _totalTransaction;

  int _profitMonth = 0;
  int get profitMonth => _profitMonth;

  final GetTotalCategory getTotalCategory;
  final GetTotalProduct getTotalProduct;
  final GetTotalTransaction getTotalTransaction;
  final GetProfitWithRange getProfitWithRange;

  DashboardTabController({
    required this.getTotalCategory,
    required this.getTotalProduct,
    required this.getTotalTransaction,
    required this.getProfitWithRange,
  });

  void initData() async {
    await getTotalCategory.call(NoParans()).then((value) {
      _totalCategory = value!;
    });

    await getTotalProduct.call(NoParans()).then((value) {
      _totalProduct = value!;
    });

    await getTotalTransaction.call(NoParans()).then((value) {
      _totalTransaction = value!;
    });

    var date = DateTime.now();
    var firstDate = DateTime(date.year, date.month, 1);
    var lastDate = DateTime(date.year, date.month + 1, 0, 23, 59, 00);

    await getProfitWithRange.call([firstDate, lastDate]).then((value) {
      _profitMonth = value;
    }).catchError((_) {});

    notifyListeners();
  }
}
