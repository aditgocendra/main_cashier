import 'package:flutter/foundation.dart';
import 'package:main_cashier/domain/usecase/transaction/delete_transaction_usecase.dart';
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

  int _rowPage = 10;
  int get rowPage => _rowPage;

  int _offsetRowPage = 0;
  int get offsetRowPage => _offsetRowPage;

  int _activeRowPage = 1;
  int get activeRowPage => _activeRowPage;

  final GetAllTransaction getAllTransaction;
  final GetDetailTransaction getDetailTransaction;
  final DeleteTransaction deleteTransaction;

  TransactionTabController({
    required this.getAllTransaction,
    required this.getDetailTransaction,
    required this.deleteTransaction,
  });

  void setTransaction() async {
    final params = ParamGetAllTransaction(
      limit: rowPage,
      offset: offsetRowPage,
    );

    await getAllTransaction.call(params).then((value) {
      _listTransaction = value;
      notifyListeners();
    }).catchError((e) {
      print(e.toString());
    });
  }

  void setDetailTransaction(int idTransaction) async {
    await getDetailTransaction.call(idTransaction).then((value) {
      _listDetailTransaction = value;
      notifyListeners();
    }).catchError((e) {
      print(e.toString());
    });
  }

  void removeTransaction(int idTransaction) async {
    await deleteTransaction.call(idTransaction).then((value) {
      _listTransaction.removeWhere((element) => element.id == idTransaction);
      notifyListeners();
    }).catchError((e) {
      print(e.toString());
    });
  }
}
