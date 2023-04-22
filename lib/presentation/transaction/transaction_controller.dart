import 'package:flutter/material.dart';

import '../../core/usecase/usecase.dart';

import '../../domain/usecase/transaction/update_counter_transaction_usecase.dart';
import '../../domain/usecase/transaction/get_counter_transaction_usecase.dart';
import '../../domain/usecase/product/select_product_usecase.dart';
import '../../domain/usecase/transaction/create_transaction_usecase.dart';
import '../../domain/entity/product_entity.dart';
import '../../domain/entity/detail_transaction_entity.dart';

class TransactionController extends ChangeNotifier {
  List<ProductEntity> _listProduct = [];
  List<ProductEntity> get listProduct => _listProduct;

  List<TextEditingController> _listTecQty = [];
  List<TextEditingController> get listTecQty => _listTecQty;

  List<int> _listTotalQty = [];
  List<int> get listTotalQty => _listTotalQty;

  int _totalPay = 0;
  int get totalPay => _totalPay;

  String _errSelectProduct = "";
  String get errSelectProduct => _errSelectProduct;

  final SelectProduct selectProduct;
  final CreateTransaction createTransaction;
  final GetCounterTransaction getCounterTransaction;
  final UpdateCounterTransaction updateCounterTransaction;

  TransactionController({
    required this.createTransaction,
    required this.selectProduct,
    required this.getCounterTransaction,
    required this.updateCounterTransaction,
  });

  void selectProductData({
    required String code,
    required VoidCallback callbackFail,
  }) async {
    // Check product is already add or not
    if (listProduct.isNotEmpty) {
      final products = listProduct.where((element) => element.code == code);

      if (products.isNotEmpty) {
        return;
      }
    }

    // Select product from database
    await selectProduct.call(code).then((value) {
      if (value.stock < 1) {
        _errSelectProduct = "This product has no stock";
        callbackFail.call();
        _errSelectProduct = "";
        return;
      }

      _listTecQty.add(TextEditingController(text: "1"));
      _listTotalQty.add(value.sellPrice);

      _listProduct.add(value);
      calculateTotalPay();
      notifyListeners();
    }).catchError((e) {
      _errSelectProduct = e.toString();
      callbackFail.call();
      _errSelectProduct = "";
    });
  }

  void changeQtyPrice(int index) {
    final val = listTecQty[index].text;
    final price = listProduct[index].sellPrice;

    if (val.isEmpty || val == "0") {
      _listTecQty[index].text = "1";
      _listTotalQty[index] = price;
      _totalPay = price;
    } else {
      _listTotalQty[index] = price * int.parse(val);

      calculateTotalPay();
    }

    notifyListeners();
  }

  void removeProduct(int index) {
    _listProduct.removeAt(index);
    _listTotalQty.removeAt(index);
    _listTecQty.removeAt(index);
    _totalPay = 0;

    calculateTotalPay();

    notifyListeners();
  }

  void calculateTotalPay() {
    _totalPay = 0;
    for (var element in listTotalQty) {
      _totalPay += element;
    }
  }

  // Transaction -------------------------------------------------------------
  Future<String> _generateNoInvoice() async {
    final date = DateTime.now();

    var result = await getCounterTransaction.call(NoParans());

    // Check month
    if (date.month > result.dateTime.month) {
      result.dateTime = date;
      result.totalTransaction = 0;

      await updateCounterTransaction.call(result).then((value) {
        if (!value) {
          return;
        }
      });
    }

    return "${date.day}${date.month.toString().padLeft(2, '0')}${date.year}-${result.totalTransaction.toString().padLeft(4, '0')}";
  }

  void addTransaction() async {
    List<DetailTransactionEntity> list = [];

    if (listProduct.isEmpty) {
      return;
    }

    for (var i = 0; i < listProduct.length; i++) {
      list.add(DetailTransactionEntity(
        id: 0,
        qty: int.parse(listTecQty[i].text),
        total: listTotalQty[i],
        idProduct: listProduct[i].code,
      ));
    }

    final params = ParamCreateTransaction(
      no: await _generateNoInvoice(),
      totalPay: totalPay,
      list: list,
    );

    await createTransaction.call(params).then((value) {});
  }
}
