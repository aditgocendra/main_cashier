import 'package:main_cashier/domain/usecase/category/delete_category_usecase.dart';
import 'package:main_cashier/domain/usecase/category/update_category_usecase.dart';

import 'data/datasource/local/category_local_datasource.dart';
import 'data/datasource/local/drift/drift_database.dart';
import 'data/repositories/category_repository_impl.dart';

import 'domain/repostitories/category_repository.dart';
import 'domain/usecase/category/create_category_usecase.dart';
import 'domain/usecase/category/get_categories_usecase.dart';

import 'presentation/home/home_controller.dart';
import 'presentation/home/tab_controller/category_tab_controller.dart';
import 'presentation/sign_in/sign_in_controller.dart';

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get listProvider => _listProvider;

// Database
DatabaseApp _databaseApp = DatabaseApp();

// Datasource
CategoryLocalDataSource _categoryLocalDataSource = CategoryLocalDataSourceImpl(
  databaseApp: _databaseApp,
);

// Repository
CategoryRepository _categoryRepository = CategoryRepositoryImpl(
  categoryLocalDataSource: _categoryLocalDataSource,
);

// Category Usecase
GetCategories _getCategories = GetCategories(
  repository: _categoryRepository,
);

CreateCategory _createCategory = CreateCategory(
  repository: _categoryRepository,
);

DeleteCategory _deleteCategory = DeleteCategory(
  repository: _categoryRepository,
);

UpdateCategory _updateCategory = UpdateCategory(
  repository: _categoryRepository,
);

List<SingleChildWidget> _listProvider = [
  ChangeNotifierProvider(
    create: (context) => HomeController(),
  ),
  ChangeNotifierProvider(
    create: (context) => CategoryTabController(
      getCategories: _getCategories,
      createCategory: _createCategory,
      deleteCategory: _deleteCategory,
      updateCategory: _updateCategory,
    ),
  ),
  ChangeNotifierProvider(
    create: (context) => SignInController(),
  )
];
