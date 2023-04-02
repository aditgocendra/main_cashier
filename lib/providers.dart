import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'data/datasource/local/product_local_datasource.dart';
import 'data/repositories/product_repository_impl.dart';
import 'data/datasource/local/category_local_datasource.dart';
import 'data/datasource/local/drift/drift_database.dart';
import 'data/repositories/category_repository_impl.dart';

import 'domain/repostitories/product_repository.dart';
import 'domain/usecase/product/create_product_usecase.dart';
import 'domain/usecase/product/delete_product_usecase.dart';
import 'domain/usecase/product/get_product_view_usecase.dart';
import 'domain/usecase/product/search_product_usecase.dart';
import 'domain/usecase/product/update_product_usecase.dart';
import 'domain/usecase/category/delete_category_usecase.dart';
import 'domain/usecase/category/search_categories_usecase.dart';
import 'domain/usecase/category/update_category_usecase.dart';
import 'domain/repostitories/category_repository.dart';
import 'domain/usecase/category/create_category_usecase.dart';
import 'domain/usecase/category/get_categories_usecase.dart';

import 'presentation/home/home_controller.dart';
import 'presentation/home/tab_controller/category_tab_controller.dart';
import 'presentation/home/tab_controller/inventory_tab_controller.dart';
import 'presentation/sign_in/sign_in_controller.dart';

List<SingleChildWidget> get listProvider => _listProvider;

// Database
DatabaseApp _databaseApp = DatabaseApp();

// Datasource
CategoryLocalDataSource _categoryLocalDataSource = CategoryLocalDataSourceImpl(
  databaseApp: _databaseApp,
);

ProductLocalDataSource _productLocalDataSource = ProductLocalDataSourceImpl(
  databaseApp: _databaseApp,
);

// Repository
CategoryRepository _categoryRepository = CategoryRepositoryImpl(
  categoryLocalDataSource: _categoryLocalDataSource,
);

ProductRepository _productRepository = ProductRepositoryImpl(
  productLocalDataSource: _productLocalDataSource,
);

// Category Usecase
GetCategories _getCategories = GetCategories(
  repository: _categoryRepository,
);

SearchCategories _searchCategories = SearchCategories(
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

// Product Usecase
GetProductView _getProductView = GetProductView(
  repository: _productRepository,
);

CreateProduct _createProduct = CreateProduct(
  repository: _productRepository,
);

UpdateProduct _updateProduct = UpdateProduct(
  repository: _productRepository,
);

DeleteProduct _deleteProduct = DeleteProduct(
  repository: _productRepository,
);

SearchProduct _searchProduct = SearchProduct(
  repository: _productRepository,
);

List<SingleChildWidget> _listProvider = [
  ChangeNotifierProvider(
    create: (context) => HomeController(),
  ),
  ChangeNotifierProvider(
    create: (context) => CategoryTabController(
      getCategories: _getCategories,
      searchCategories: _searchCategories,
      createCategory: _createCategory,
      deleteCategory: _deleteCategory,
      updateCategory: _updateCategory,
    ),
  ),
  ChangeNotifierProvider(
    create: (context) => SignInController(),
  ),
  ChangeNotifierProvider(
    create: (context) => InventoryTabController(
      getProductView: _getProductView,
      createProduct: _createProduct,
      getCategories: _getCategories,
      deleteProduct: _deleteProduct,
      updateProduct: _updateProduct,
      searchProduct: _searchProduct,
    ),
  )
];
