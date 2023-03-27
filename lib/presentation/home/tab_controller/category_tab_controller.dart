import 'package:flutter/material.dart';
import '../../../domain/usecase/category/update_category_usecase.dart';
import '../../../domain/entity/category_entity.dart';
import '../../../domain/usecase/category/delete_category_usecase.dart';
import '../../../domain/usecase/category/create_category_usecase.dart';
import '../../../domain/usecase/category/get_categories_usecase.dart';

class CategoryTabController extends ChangeNotifier {
  final GetCategories getCategories;
  final CreateCategory createCategory;
  final DeleteCategory deleteCategory;
  final UpdateCategory updateCategory;

  CategoryTabController({
    required this.getCategories,
    required this.createCategory,
    required this.deleteCategory,
    required this.updateCategory,
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

  void addCategory(String title) async {
    await createCategory.call(title).then((value) {
      _listCategory.add(value);
      notifyListeners();
    }).catchError((e) {
      _errorDialog = e.toString();
    });
  }

  void removeCategory(CategoryEntity val) async {
    await deleteCategory.call(val).then((value) {
      _listCategory.removeAt(
        listCategory.indexWhere((element) => element.id == val.id),
      );
      notifyListeners();
    }).catchError((e) {
      _errorDialog = e.toString();
    });
  }

  void changeCategory(CategoryEntity newCtg) async {
    await updateCategory.call(newCtg).then((value) {
      if (!value) {
        _errorDialog = "Unknown Error";
      }
    }).catchError((e) {
      _errorDialog = e.toString();
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

  void updateRowPage(int newRowPage) {
    _rowPage = newRowPage;
    _offsetRowPage = 0;
    _activeRowPage = 1;
    setCategories();
  }

  void nextPage() {
    _offsetRowPage = offsetRowPage + rowPage;
    _activeRowPage += 1;
    setCategories();
  }

  void backPage() {
    if (offsetRowPage <= 0) {
      return;
    }

    _offsetRowPage = offsetRowPage - rowPage;
    _activeRowPage -= 1;
    setCategories();
  }

  void resetErrorDialog() => _errorDialog = "";
}
