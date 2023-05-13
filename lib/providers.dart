import 'package:main_cashier/data/datasource/local/login_info_local_datasource.dart';
import 'package:main_cashier/data/repositories/login_info_repository_impl.dart';
import 'package:main_cashier/domain/repostitories/login_info_repository.dart';
import 'package:main_cashier/domain/usecase/login_info/create_login_info_usecase.dart';
import 'package:main_cashier/domain/usecase/login_info/delete_login_info_usecase.dart';
import 'package:main_cashier/domain/usecase/login_info/get_login_info_usecase.dart';
import 'package:main_cashier/domain/usecase/user/get_total_user_usecase.dart';
import 'package:main_cashier/domain/usecase/user/get_user_with_username_usecase.dart';
import 'package:main_cashier/auth_state.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'data/datasource/local/transaction_local_datasource.dart';
import 'data/datasource/local/user_local_datasource.dart';
import 'data/repositories/transaction_repository_impl.dart';
import 'data/repositories/user_repository_impl.dart';
import 'data/datasource/local/product_local_datasource.dart';
import 'data/repositories/product_repository_impl.dart';
import 'data/datasource/local/category_local_datasource.dart';
import 'data/datasource/local/drift/drift_database.dart';
import 'data/repositories/category_repository_impl.dart';
import 'data/datasource/local/role_local_datasource.dart';
import 'data/repositories/role_repository_impl.dart';
import 'data/datasource/local/backup_local_datasource.dart';
import 'data/datasource/local/color_app_local_datasource.dart';
import 'data/datasource/local/path_file_local_datasource.dart';
import 'data/repositories/backup_repository_impl.dart';
import 'data/repositories/color_app_repository_impl.dart';
import 'data/repositories/path_file_repository_impl.dart';

import 'domain/repostitories/backup_repository.dart';
import 'domain/repostitories/color_app_repository.dart';
import 'domain/repostitories/path_file_repository.dart';
import 'domain/usecase/backup/export_database_usecase.dart';
import 'domain/usecase/category/get_total_category_usecase.dart';
import 'domain/usecase/color_app/get_color_app_usecase.dart';
import 'domain/usecase/color_app/update_color_app_usecase.dart';
import 'domain/usecase/path_file/get_path_file_usecase.dart';
import 'domain/usecase/path_file/update_path_file_usecase.dart';
import 'domain/usecase/product/delete_product_category_usecase.dart';
import 'domain/usecase/product/get_single_product_category_usecase.dart';
import 'domain/usecase/product/get_total_product_usecase.dart';
import 'domain/usecase/transaction/get_total_transaction_usecase.dart';
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
import 'domain/repostitories/role_repository.dart';
import 'domain/repostitories/transaction_repository.dart';
import 'domain/repostitories/user_repository.dart';
import 'domain/usecase/product/select_product_usecase.dart';
import 'domain/usecase/transaction/create_transaction_usecase.dart';
import 'domain/usecase/transaction/delete_transaction_usecase.dart';
import 'domain/usecase/transaction/get_all_transaction_usecase.dart';
import 'domain/usecase/transaction/get_counter_transaction_usecase.dart';
import 'domain/usecase/transaction/get_detail_transaction_usecase.dart';
import 'domain/usecase/transaction/get_omzet_transaction_with_range_usecase.dart';
import 'domain/usecase/transaction/get_profit_transaction_with_range_usecase.dart';
import 'domain/usecase/transaction/get_report_transactions_usecase.dart';
import 'domain/usecase/transaction/search_transaction_usecase.dart';
import 'domain/usecase/transaction/update_counter_transaction_usecase.dart';
import 'domain/usecase/user/change_pass_user_usecase.dart';
import 'domain/usecase/user/create_user_usecase.dart';
import 'domain/usecase/user/delete_user_usecase.dart';
import 'domain/usecase/user/get_view_user_usecase.dart';
import 'domain/usecase/user/search_user_usecase.dart';
import 'domain/usecase/user/update_user_usecase.dart';
import 'domain/usecase/role/get_role_usecase.dart';

import 'presentation/home/tab_controller/dashboard_tab_controller.dart';
import 'presentation/home/tab_controller/settings_tab_controller.dart';
import 'presentation/home/home_controller.dart';
import 'presentation/home/tab_controller/category_tab_controller.dart';
import 'presentation/home/tab_controller/inventory_tab_controller.dart';
import 'presentation/sign_in/sign_in_controller.dart';
import 'presentation/home/tab_controller/users_tab_controller.dart';
import 'presentation/home/tab_controller/transaction_tab_controller.dart';
import 'presentation/transaction/transaction_controller.dart';

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

RoleLocalDataSource _roleLocalDataSource = RoleLocalDataSourceImpl(
  databaseApp: _databaseApp,
);

UserLocalDataSource _userLocalDataSource = UserLocalDataSourceImpl(
  databaseApp: _databaseApp,
);

TransactionLocalDataSource _transactionLocalDataSource =
    TransactionLocalDataSourceImpl(
  databaseApp: _databaseApp,
);

ColorAppLocalDataSource _colorAppLocalDataSource = ColorAppLocalDataSourceImpl(
  databaseApp: _databaseApp,
);

PathFileLocalDataSource _pathFileLocalDataSource = PathFileLocalDataSourceImpl(
  databaseApp: _databaseApp,
);

BackupLocalDataSource _backupLocalDataSource = BackupLocalDataSourceImpl(
  databaseApp: _databaseApp,
);

LoginInfoDataLocalSource _loginInfoDataLocalSource =
    LoginInfoLocalDataSourceImpl(
  databaseApp: _databaseApp,
);

// Repository
CategoryRepository _categoryRepository = CategoryRepositoryImpl(
  categoryLocalDataSource: _categoryLocalDataSource,
);

ProductRepository _productRepository = ProductRepositoryImpl(
  productLocalDataSource: _productLocalDataSource,
);

RoleRepository _roleRepository = RoleRepositoryImpl(
  roleLocalDataSource: _roleLocalDataSource,
);

UserRepository _userRepository = UserRepositoryImpl(
  userLocalDataSource: _userLocalDataSource,
);

TransactionRepository _transactionRepository = TransactionRepositoryImpl(
  transactionLocalDataSource: _transactionLocalDataSource,
);

ColorAppRepository _colorAppRepository = ColorAppRepositoryImpl(
  colorAppLocalDataSource: _colorAppLocalDataSource,
);

PathFileRepository _pathFileRepository = PathFileRepositoryImpl(
  pathFileLocalDataSource: _pathFileLocalDataSource,
);

BackupRepository _backupRepository = BackupRepositoryImpl(
  backupLocalDataSource: _backupLocalDataSource,
);

LoginInfoRepository _loginInfoRepository = LoginInfoRepositoryImpl(
  loginInfoDataLocalSource: _loginInfoDataLocalSource,
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

GetTotalCategory _getTotalCategory = GetTotalCategory(
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

SelectProduct _selectProduct = SelectProduct(
  repository: _productRepository,
);

GetTotalProduct _getTotalProduct = GetTotalProduct(
  repository: _productRepository,
);

GetSingleProductCategory _getSingleProductCategory = GetSingleProductCategory(
  repository: _productRepository,
);

DeleteProductCategory _deleteProductCategory = DeleteProductCategory(
  repository: _productRepository,
);

// Role Usecase
GetRole _getRole = GetRole(
  repository: _roleRepository,
);

// User Usecase
GetViewUser _getViewUser = GetViewUser(
  repository: _userRepository,
);

CreateUser _createUser = CreateUser(
  repository: _userRepository,
);

UpdateUser _updateUser = UpdateUser(
  repository: _userRepository,
);

DeleteUser _deleteUser = DeleteUser(
  repository: _userRepository,
);

ChangePassword _changePassword = ChangePassword(
  repository: _userRepository,
);

SearchUser _searchUser = SearchUser(
  repository: _userRepository,
);

GetUserWithUsername _getUserWithUsername = GetUserWithUsername(
  repository: _userRepository,
);

GetTotalUser _getTotalUser = GetTotalUser(repository: _userRepository);

// Transaction Usecase
CreateTransaction _createTransaction = CreateTransaction(
  repository: _transactionRepository,
);

GetAllTransaction _getAllTransaction = GetAllTransaction(
  repository: _transactionRepository,
);

GetDetailTransaction _getDetailTransaction = GetDetailTransaction(
  repository: _transactionRepository,
);

SearchTransaction _searchTransaction = SearchTransaction(
  repository: _transactionRepository,
);

GetCounterTransaction _getCounterTransaction = GetCounterTransaction(
  repository: _transactionRepository,
);

DeleteTransaction _deleteTransaction = DeleteTransaction(
  repository: _transactionRepository,
);

UpdateCounterTransaction _updateCounterTransaction = UpdateCounterTransaction(
  repository: _transactionRepository,
);

GetReportTransactions _getReportTransactions = GetReportTransactions(
  repository: _transactionRepository,
);

GetOmzetWithRange _getOmzetWithRange = GetOmzetWithRange(
  repository: _transactionRepository,
);

GetProfitWithRange _getProfitWithRange = GetProfitWithRange(
  repository: _transactionRepository,
);

GetTotalTransaction _getTotalTransaction = GetTotalTransaction(
  repository: _transactionRepository,
);

// Color App Usecase
GetColorApp _getColorApp = GetColorApp(
  repository: _colorAppRepository,
);

UpdateColorApp _updateColorApp = UpdateColorApp(
  repository: _colorAppRepository,
);

GetPathFile _getPathFile = GetPathFile(
  repository: _pathFileRepository,
);

UpdatePathFile _updatePathFile = UpdatePathFile(
  repository: _pathFileRepository,
);

// Backup Database Usecase
ExportDatabase _exportDatabase = ExportDatabase(
  repository: _backupRepository,
);

// Login Info Usecase
GetLoginInfo _getLoginInfo = GetLoginInfo(
  repository: _loginInfoRepository,
);

CreateLoginInfo _createLoginInfo = CreateLoginInfo(
  repository: _loginInfoRepository,
);

DeleteLoginInfo _deleteLoginInfo = DeleteLoginInfo(
  repository: _loginInfoRepository,
);

// ----------------------------------------------
AuthState initialState = AuthState(
  getLoginInfo: _getLoginInfo,
);

List<SingleChildWidget> _listProvider = [
  ChangeNotifierProvider(
    create: (context) => HomeController(
      getTotalUser: _getTotalUser,
      deleteLoginInfo: _deleteLoginInfo,
    ),
  ),
  ChangeNotifierProvider(
    create: (context) => CategoryTabController(
      getCategories: _getCategories,
      searchCategories: _searchCategories,
      createCategory: _createCategory,
      deleteCategory: _deleteCategory,
      updateCategory: _updateCategory,
      getSingleProductCategory: _getSingleProductCategory,
      deleteProductCategory: _deleteProductCategory,
    ),
  ),
  ChangeNotifierProvider(
    create: (context) => SignInController(
      getUserWithUsername: _getUserWithUsername,
      createLoginInfo: _createLoginInfo,
    ),
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
  ),
  ChangeNotifierProvider(
    create: (context) => UsersTabController(
      getRole: _getRole,
      createUser: _createUser,
      getViewUser: _getViewUser,
      updateUser: _updateUser,
      deleteUser: _deleteUser,
      changePassword: _changePassword,
      searchUser: _searchUser,
    ),
  ),
  ChangeNotifierProvider(
    create: (context) => TransactionTabController(
      getAllTransaction: _getAllTransaction,
      getDetailTransaction: _getDetailTransaction,
      deleteTransaction: _deleteTransaction,
      searchTransaction: _searchTransaction,
      getReportTransactions: _getReportTransactions,
      getOmzetWithRange: _getOmzetWithRange,
      getProfitWithRange: _getProfitWithRange,
    ),
  ),
  ChangeNotifierProvider(
    create: (context) => TransactionController(
      selectProduct: _selectProduct,
      createTransaction: _createTransaction,
      getCounterTransaction: _getCounterTransaction,
      updateCounterTransaction: _updateCounterTransaction,
    ),
  ),
  ChangeNotifierProvider(
    create: (context) => SettingsTabController(
      getColorApp: _getColorApp,
      updateColorApp: _updateColorApp,
      getPathFile: _getPathFile,
      updatePathFile: _updatePathFile,
      exportDatabase: _exportDatabase,
    ),
  ),
  ChangeNotifierProvider(
    create: (context) => DashboardTabController(
      getTotalCategory: _getTotalCategory,
      getTotalProduct: _getTotalProduct,
      getTotalTransaction: _getTotalTransaction,
      getProfitWithRange: _getProfitWithRange,
    ),
  ),
  ChangeNotifierProvider<AuthState>(
    lazy: false,
    create: (context) => initialState,
  ),
];
