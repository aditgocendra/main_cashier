import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/entity/product_transaction_entity.dart';
import 'package:main_cashier/domain/repostitories/transaction_repository.dart';

class CreateTransaction implements Usecase<dynamic, ParamCreateTransaction> {
  final TransactionRepository repository;

  CreateTransaction({
    required this.repository,
  });

  @override
  Future call(ParamCreateTransaction params) async {
    return await repository.createTransaction(
      no: params.no,
      totalPay: params.totalPay,
      list: params.list,
    );
  }
}

class ParamCreateTransaction {
  String no;
  int totalPay;
  List<ProductTransactionEntity> list;

  ParamCreateTransaction({
    required this.no,
    required this.totalPay,
    required this.list,
  });
}
