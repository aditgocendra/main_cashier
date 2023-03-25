import 'package:flutter/material.dart';
import '../../../domain/usecase/category/update_category_usecase.dart';
import '../../../core/usecase/usecase.dart';
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
    await getCategories.call(NoParans()).then((value) {
      _listCategory = value;
      notifyListeners();
    });
  }

  void resetErrorDialog() => _errorDialog = "";
}
