import 'dart:math';
import 'package:flutter/material.dart';
import '../../../domain/entity/category_entity.dart';
import '../../../domain/entity/product_entity.dart';
import '../../../domain/usecase/category/get_categories_usecase.dart';
import '../../../domain/usecase/product/get_product_categories.dart';
import '../../../domain/usecase/product/get_product_view_usecase.dart';
import '../../../domain/usecase/transaction/get_profit_transaction_with_range_usecase.dart';
import '../../../domain/usecase/category/get_total_category_usecase.dart';
import '../../../domain/usecase/product/get_total_product_usecase.dart';
import '../../../domain/usecase/transaction/get_total_transaction_usecase.dart';
import '../../../core/usecase/usecase.dart';

class DashboardTabController extends ChangeNotifier {
  int _totalProduct = 0;
  int get totalProduct => _totalProduct;

  int _totalCategory = 0;
  int get totalCategory => _totalCategory;

  int _totalTransaction = 0;
  int get totalTransaction => _totalTransaction;

  int _profitMonth = 0;
  int get profitMonth => _profitMonth;

  int _yearProfitMonthYear = DateTime.now().year;
  int get yearProfitMonthYear => _yearProfitMonthYear;

  final List<int> _profitMonthInYear = [];
  List<int> get profitMonthInYear => _profitMonthInYear;

  List<ProductViewEntity> _bestSellerProduct = [];
  List<ProductViewEntity> get bestSellerProduct => _bestSellerProduct;

  final List<Map<String, dynamic>> _bestSellerCategory = [];
  List<Map<String, dynamic>> get bestSellerCategory => _bestSellerCategory;

  double _percentagePieChart = 0;
  double get percentagePieChart => _percentagePieChart;

  List<CategoryEntity> _categories = [];

  // Chart Settings
  final List<Map<String, dynamic>> _profitChartSettings = [
    {
      'setting': 'Grid',
      'value': false,
    },
    {
      'setting': 'Border',
      'value': false,
    },
    {
      'setting': 'Indicator',
      'value': true,
    },
    {
      'setting': 'Area Bar',
      'value': false,
    },
  ];
  List<Map<String, dynamic>> get profitChartSettings => _profitChartSettings;

  final GetTotalCategory getTotalCategory;
  final GetTotalProduct getTotalProduct;
  final GetTotalTransaction getTotalTransaction;
  final GetProfitWithRange getProfitWithRange;
  final GetProductView getProductView;
  final GetCategories getCategories;
  final GetProductCategories getProductCategories;

  DashboardTabController({
    required this.getTotalCategory,
    required this.getTotalProduct,
    required this.getTotalTransaction,
    required this.getProfitWithRange,
    required this.getProductView,
    required this.getCategories,
    required this.getProductCategories,
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

    setProfitThisMonth();
    setProfitMonthInYear();
    setBestSellerProduct();
    setBestSellerCategories();

    notifyListeners();
  }

  void setProfitThisMonth() async {
    var date = DateTime.now();
    var firstDate = DateTime(date.year, date.month, 1);
    var lastDate = DateTime(date.year, date.month + 1, 0, 23, 59, 00);

    await getProfitWithRange.call([firstDate, lastDate]).then((value) {
      _profitMonth = value;
    }).catchError((_) {});
  }

  void setProfitMonthInYear() async {
    _profitMonthInYear.clear();

    for (var i = 1; i <= 12; i++) {
      var firstDate = DateTime(yearProfitMonthYear, i, 1);
      var lastDate = DateTime(yearProfitMonthYear, i + 1, 0, 23, 59, 00);

      await getProfitWithRange.call([firstDate, lastDate]).then((value) {
        _profitMonthInYear.add(value);
      });
    }
    notifyListeners();
  }

  void setBestSellerProduct() async {
    final params = ParamGetProductView(
      limit: 3,
      offset: 0,
      orderColumn: 4,
      orderSort: true,
    );

    await getProductView.call(params).then((value) {
      _bestSellerProduct = value;
      notifyListeners();
    });
  }

  void setBestSellerCategories() async {
    final paramGetCategories = ParamGetCategories(limit: 0, offset: 0);

    await getCategories.call(paramGetCategories).then((value) {
      _categories = value;
    });

    _bestSellerCategory.clear();

    for (var ctg in _categories) {
      await getProductCategories.call(ctg.id).then((value) {
        int totalSold = 0;

        for (var product in value) {
          totalSold += product.sold;
        }

        _bestSellerCategory.add({
          'title_ctg': ctg.title,
          'total_sold': totalSold.toDouble(),
          'color':
              Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5)
        });
      });
    }

    double totalAllSold = 0;
    for (var element in bestSellerCategory) {
      totalAllSold += element['total_sold'];
    }
    _percentagePieChart = 100 / totalAllSold;

    notifyListeners();
  }

  void changeYearProfitMonthYear(int year) {
    _yearProfitMonthYear = year;
  }

  void setSettingProfitBar({
    required int index,
    required bool value,
  }) {
    _profitChartSettings[index]['value'] = value;
    notifyListeners();
  }
}
