import 'package:flutter/material.dart';
import 'package:main_cashier/domain/usecase/product/search_product_usecase.dart';
import '../../../core/usecase/usecase.dart';

import '../../../domain/entity/category_entity.dart';
import '../../../domain/entity/product_entity.dart';
import '../../../domain/usecase/category/get_categories_usecase.dart';
import '../../../domain/usecase/product/create_product_usecase.dart';
import '../../../domain/usecase/product/delete_product_usecase.dart';
import '../../../domain/usecase/product/get_product_view_usecase.dart';
import '../../../domain/usecase/product/update_product_usecase.dart';

class InventoryTabController extends ChangeNotifier {
  List<CategoryEntity> _listCategories = [];
  List<CategoryEntity> get listCategories => _listCategories;

  List<ProductViewEntity> _listProduct = [];
  List<ProductViewEntity> get listProduct => _listProduct;

  CategoryEntity? _categorySelection;
  CategoryEntity? get categorySelection => _categorySelection;

  String _errDialogMessage = "";
  String get errDialogMessage => _errDialogMessage;

  bool _isSearch = false;
  bool get isSearch => _isSearch;

  int _rowPage = 10;
  int get rowPage => _rowPage;

  int _offsetRowPage = 0;
  int get offsetRowPage => _offsetRowPage;

  int _activeRowPage = 1;
  int get activeRowPage => _activeRowPage;

  // Usecase
  GetCategories getCategories;
  GetProductView getProductView;
  CreateProduct createProduct;
  DeleteProduct deleteProduct;
  UpdateProduct updateProduct;
  SearchProduct searchProduct;

  InventoryTabController({
    required this.getProductView,
    required this.createProduct,
    required this.getCategories,
    required this.deleteProduct,
    required this.updateProduct,
    required this.searchProduct,
  });

  void setCategories() async {
    final ParamGetCategories params = ParamGetCategories(limit: 0, offset: 0);
    await getCategories.call(params).then((value) => _listCategories = value);
  }

  void setProductData() async {
    final params = ParamGetProductView(limit: rowPage, offset: offsetRowPage);
    await getProductView.call(params).then((value) {
      _listProduct = value;
      notifyListeners();
    });
  }

  void addProduct({
    required String code,
    required String name,
    required int price,
    required int stock,
    required int sold,
    required int idCategory,
    required VoidCallback callbackSuccess,
  }) async {
    ProductEntity productEntity = ProductEntity(
      code: code,
      name: name,
      price: price,
      stock: stock,
      sold: sold,
      idCategory: idCategory,
      createdAt: DateTime.now(),
    );

    await createProduct.call(productEntity).then((value) {
      _listProduct.add(value);
      notifyListeners();
      callbackSuccess.call();
    }).catchError((e) {
      _errDialogMessage = e.toString();
      notifyListeners();
    });
  }

  void searchDataProduct(String keyword) async {
    await searchProduct.call(keyword).then((value) {
      _listProduct = value;
      tooggleIsSearch();
      notifyListeners();
    }).catchError((e) {
      _errDialogMessage = e.toString();
      notifyListeners();
    });
  }

  void removeProduct(String code) async {
    await deleteProduct.call(code).then((rowsAffected) {
      if (rowsAffected == 0) {
        return;
      }

      _listProduct.removeAt(
        listProduct.indexWhere((element) => element.code == code),
      );

      notifyListeners();
    });
  }

  void changeProduct(ProductEntity productEntity) async {
    await updateProduct.call(productEntity).then((value) {
      final index = listProduct.indexWhere(
        (element) => element.code == productEntity.code,
      );
      _listProduct[index] = value;
      notifyListeners();
    }).catchError((e) {
      _errDialogMessage = e.toString();
      notifyListeners();
    });
  }

  void updateRowPage(int newRowPage) {
    _rowPage = newRowPage;
    _offsetRowPage = 0;
    _activeRowPage = 1;
    setCategories();
  }

  void nextPage() {
    if (isSearch) return;

    _offsetRowPage = offsetRowPage + rowPage;
    _activeRowPage += 1;
    setCategories();
  }

  void backPage() {
    if (isSearch) return;

    if (offsetRowPage <= 0) return;

    _offsetRowPage = offsetRowPage - rowPage;
    _activeRowPage -= 1;
    setCategories();
  }

  void changeCategorySelection(CategoryEntity category) =>
      _categorySelection = category;

  void tooggleIsSearch() => _isSearch = isSearch ? false : true;

  void resetDialogAttr() {
    _errDialogMessage = "";
    _categorySelection = null;
  }
}
