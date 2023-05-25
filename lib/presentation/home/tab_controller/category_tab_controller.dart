import 'package:flutter/material.dart';
import '../../../domain/usecase/category/search_categories_usecase.dart';
import '../../../domain/usecase/product/delete_product_category_usecase.dart';
import '../../../domain/usecase/product/get_single_product_category_usecase.dart';
import '../../../domain/usecase/category/update_category_usecase.dart';
import '../../../domain/entity/category_entity.dart';
import '../../../domain/usecase/category/delete_category_usecase.dart';
import '../../../domain/usecase/category/create_category_usecase.dart';
import '../../../domain/usecase/category/get_categories_usecase.dart';

class CategoryTabController extends ChangeNotifier {
  final GetCategories getCategories;
  final SearchCategories searchCategories;
  final CreateCategory createCategory;
  final DeleteCategory deleteCategory;
  final UpdateCategory updateCategory;
  final GetSingleProductCategory getSingleProductCategory;
  final DeleteProductCategory deleteProductCategory;

  CategoryTabController({
    required this.getCategories,
    required this.searchCategories,
    required this.createCategory,
    required this.deleteCategory,
    required this.updateCategory,
    required this.getSingleProductCategory,
    required this.deleteProductCategory,
  });

  List<CategoryEntity> _listCategory = [];
  List<CategoryEntity> get listCategory => _listCategory;

  String _errorDialog = "";
  String get errorDialog => _errorDialog;

  int _rowPage = 10;
  int get rowPage => _rowPage;

  int _offsetRowPage = 0;
  int get offsetRowPage => _offsetRowPage;

  int _activeRowPage = 1;
  int get activeRowPage => _activeRowPage;

  bool _isSearch = false;
  bool get isSearch => _isSearch;

  void addCategory({
    required String title,
    required VoidCallback callbackSuccess,
    required VoidCallback callbackFail,
  }) async {
    await createCategory.call(title.toLowerCase()).then((value) {
      _listCategory.add(value);
      callbackSuccess.call();
      notifyListeners();
    }).catchError((e) {
      _setError(e.toString());
      callbackFail.call();
      notifyListeners();
    });
  }

  void checkProductInCategory({
    required int idCategory,
    required VoidCallback callbackProductIsReady,
    required VoidCallback callbackProductNotReady,
  }) async {}

  void removeCategory(CategoryEntity val) async {
    // Check product in category
    await getSingleProductCategory.call(val.id).then((value) async {
      // Delete product with params category
      if (value != null) {
        await deleteProductCategory.call(val.id);
      }

      // Delete category
      await deleteCategory.call(val).then((value) {
        _listCategory.removeAt(
          listCategory.indexWhere((element) => element.id == val.id),
        );

        notifyListeners();
      }).catchError((e) {
        _setError(e.toString());
      });
    }).catchError((e) {
      _setError(e.toString());
    });
  }

  void changeCategory({
    required CategoryEntity newCtg,
    required VoidCallback callbackSuccess,
    required VoidCallback callbackFail,
  }) async {
    await updateCategory.call(newCtg).then((value) {
      if (!value) {
        _setError("Unknown Error");
        notifyListeners();
      }

      final index = listCategory.indexWhere(
        (element) => element.id == newCtg.id,
      );

      callbackSuccess.call();
      _listCategory[index] = newCtg;
      notifyListeners();
    }).catchError((e) {
      _setError(e.toString());
      callbackFail.call();
    });
  }

  void setCategories() async {
    final param = ParamGetCategories(limit: rowPage, offset: offsetRowPage);

    await getCategories.call(param).then((value) {
      if (value.isEmpty) {
        return;
      }

      _listCategory = value;

      notifyListeners();
    });
  }

  void searchDataCategories(String keyword) async {
    await searchCategories.call(keyword).then((value) {
      if (value.isNotEmpty) {
        _listCategory = value;
        tooggleIsSearch();
        notifyListeners();
      }
    });
  }

  void _setError(String err) => _errorDialog = err;

  void updateRowPage(int newRowPage) {
    _rowPage = newRowPage;
    _offsetRowPage = 0;
    _activeRowPage = 1;
    setCategories();
  }

  void nextPage() {
    if (isSearch) {
      return;
    }

    _offsetRowPage = offsetRowPage + rowPage;
    _activeRowPage += 1;
    setCategories();
  }

  void backPage() {
    if (isSearch) return;
    if (offsetRowPage <= 0) {
      return;
    }

    _offsetRowPage = offsetRowPage - rowPage;
    _activeRowPage -= 1;
    setCategories();
  }

  void tooggleIsSearch() => _isSearch = isSearch ? false : true;

  void resetErrorDialog() => _errorDialog = "";

  void initTab() {
    _listCategory.clear();
    _rowPage = 10;
    _offsetRowPage = 0;
    _activeRowPage = 1;
    _isSearch = false;
    resetErrorDialog();
  }
}
