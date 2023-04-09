import 'package:flutter/material.dart';
import 'package:main_cashier/domain/entity/product_entity.dart';
import 'package:main_cashier/domain/usecase/product/select_product_usecase.dart';

class TransactionController extends ChangeNotifier {
  List<ProductEntity> _listProduct = [];
  List<ProductEntity> get listProduct => _listProduct;

  List<TextEditingController> _listTecQty = [];
  List<TextEditingController> get listTecQty => _listTecQty;

  List<int> _listTotalQty = [];
  List<int> get listTotalQty => _listTotalQty;

  int _totalPay = 0;
  int get totalPay => _totalPay;

  String? _errSelectProduct;
  String? get errSelectProduct => _errSelectProduct;

  final SelectProduct selectProduct;

  TransactionController({
    required this.selectProduct,
  });

  void selectProductData(String code) async {
    if (listProduct.isNotEmpty) {
      final product = listProduct.where((element) => element.code == code);

      if (product.isNotEmpty) {
        print("Product already exist");
        return;
      }
    }

    await selectProduct.call(code).then((value) {
      _listTecQty.add(TextEditingController(text: "1"));
      _listTotalQty.add(value.price);
      _listProduct.add(value);
      _totalPay = value.price;
      notifyListeners();
    }).catchError((e) {
      print(e.toString());
    });
  }

  void changeQtyPrice(int index) {
    final val = listTecQty[index].text;
    final price = listProduct[index].price;

    if (val.isEmpty || val == "0") {
      _listTecQty[index].text = "1";
      _listTotalQty[index] = price;
      _totalPay = price;
    } else {
      _listTotalQty[index] = price * int.parse(val);
      _totalPay = 0;
      for (var element in listTotalQty) {
        _totalPay += element;
      }
    }

    notifyListeners();
  }

  void removeProduct(int index) {
    _listProduct.removeAt(index);
    _listTotalQty.removeAt(index);
    _listTecQty.removeAt(index);
    _totalPay = 0;

    for (var element in listTotalQty) {
      _totalPay += element;
    }

    notifyListeners();
  }
}
