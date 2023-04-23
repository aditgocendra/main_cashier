import 'package:flutter/foundation.dart';
import '../../../domain/usecase/transaction/delete_transaction_usecase.dart';
import '../../../domain/usecase/transaction/get_omzet_transaction_with_range_usecase.dart';
import '../../../domain/usecase/transaction/get_profit_transaction_with_range_usecase.dart';
import '../../../domain/usecase/transaction/get_report_transactions_usecase.dart';
import '../../../domain/usecase/transaction/search_transaction_usecase.dart';
import '../../../domain/entity/detail_transaction_entity.dart';
import '../../../domain/entity/transaction_entity.dart';
import '../../../domain/usecase/transaction/get_detail_transaction_usecase.dart';
import '../../../domain/usecase/transaction/get_all_transaction_usecase.dart';

class TransactionTabController extends ChangeNotifier {
  List<TransactionEntity> _listTransaction = [];
  List<TransactionEntity> get listTransaction => _listTransaction;

  List<DetailTransactionViewEntity> _listDetailTransaction = [];
  List<DetailTransactionViewEntity> get listDetailTransaction =>
      _listDetailTransaction;

  List<DateTime> _rangeDatePicker = [
    DateTime.now(),
    DateTime.now(),
  ];
  List<DateTime> get rangeDatePicker => _rangeDatePicker;

  int _rowPage = 10;
  int get rowPage => _rowPage;

  int _offsetRowPage = 0;
  int get offsetRowPage => _offsetRowPage;

  int _activeRowPage = 1;
  int get activeRowPage => _activeRowPage;

  bool _isSearch = false;
  bool get isSearch => _isSearch;

  String _errDialogMessage = "";
  String get errDialogMessage => _errDialogMessage;

  final GetAllTransaction getAllTransaction;
  final GetDetailTransaction getDetailTransaction;
  final DeleteTransaction deleteTransaction;
  final SearchTransaction searchTransaction;
  final GetReportTransactions getReportTransactions;
  final GetOmzetWithRange getOmzetWithRange;
  final GetProfitWithRange getProfitWithRange;

  TransactionTabController({
    required this.getAllTransaction,
    required this.getDetailTransaction,
    required this.deleteTransaction,
    required this.searchTransaction,
    required this.getReportTransactions,
    required this.getOmzetWithRange,
    required this.getProfitWithRange,
  });

  Future<List<DetailTransactionViewEntity>> getReportTransaction() async {
    return await getReportTransactions.call([
      rangeDatePicker[0],
      rangeDatePicker[1],
    ]);
  }

  void setTransaction() async {
    final params = ParamGetAllTransaction(
      limit: rowPage,
      offset: offsetRowPage,
    );

    await getAllTransaction.call(params).then((value) {
      _listTransaction = value;
      notifyListeners();
    });
  }

  void setDetailTransaction({
    required int idTransaction,
    required VoidCallback callbackSuccess,
    required VoidCallback callbackFail,
  }) async {
    await getDetailTransaction.call(idTransaction).then((value) {
      _listDetailTransaction = value;
      notifyListeners();
      callbackSuccess.call();
    }).catchError((e) {
      _setError(e.toString());
      callbackFail.call();
      _setError("");
    });
  }

  void searchDataTransaction(String keyword) async {
    await searchTransaction.call(keyword).then((value) {
      _listTransaction = value;
      tooggleIsSearch();
      notifyListeners();
    });
  }

  Future<int?> getOmzetTransactionWithRange() async {
    return await getOmzetWithRange.call(rangeDatePicker);
  }

  Future<int> getProfitTransactionWithRange() async {
    return await getProfitWithRange.call(rangeDatePicker);
  }

  void removeTransaction({
    required int idTransaction,
    required VoidCallback callbackFail,
    required VoidCallback callbackSuccess,
  }) async {
    await deleteTransaction.call(idTransaction).then((value) {
      _listTransaction.removeWhere((element) => element.id == idTransaction);
      notifyListeners();
      callbackSuccess.call();
    }).catchError((e) {
      _setError(e.toString());
      callbackFail.call();
      _setError("");
    });
  }

  void _setError(String e) => _errDialogMessage = e;

  void tooggleIsSearch() => _isSearch = isSearch ? false : true;

  void updateRowPage(int newRowPage) {
    _rowPage = newRowPage;
    _offsetRowPage = 0;
    _activeRowPage = 1;
    setTransaction();
  }

  void nextPage() {
    if (isSearch) {
      return;
    }

    _offsetRowPage = offsetRowPage + rowPage;
    _activeRowPage += 1;
    setTransaction();
  }

  void backPage() {
    if (isSearch) return;
    if (offsetRowPage <= 0) {
      return;
    }

    _offsetRowPage = offsetRowPage - rowPage;
    _activeRowPage -= 1;
    setTransaction();
  }

  void setSelectionRangeDate(List<DateTime?> newRangeDate) {
    final endDate = DateTime(
      newRangeDate[1]!.year,
      newRangeDate[1]!.month,
      newRangeDate[1]!.day,
      23,
      59,
      59,
    );

    _rangeDatePicker = [newRangeDate[0]!, endDate];
  }
}
