import 'package:flutter/foundation.dart';
import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/usecase/category/get_total_category_usecase.dart';
import 'package:main_cashier/domain/usecase/product/get_total_product_usecase.dart';

class DashboardTabController extends ChangeNotifier {
  int _totalProduct = 0;
  int get totalProduct => _totalProduct;

  int _totalCategory = 0;
  int get totalCategory => _totalCategory;

  final GetTotalCategory getTotalCategory;
  final GetTotalProduct getTotalProduct;

  DashboardTabController({
    required this.getTotalCategory,
    required this.getTotalProduct,
  });

  void initData() async {
    await getTotalCategory.call(NoParans()).then((value) {
      _totalCategory = value!;
    });

    await getTotalProduct.call(NoParans()).then((value) {
      _totalProduct = value!;
    });

    notifyListeners();
  }
}
