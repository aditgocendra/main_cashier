class TransactionEntity {
  int id;
  String numInvoice;
  int totalPay;
  DateTime dateTransaction;

  TransactionEntity({
    required this.id,
    required this.numInvoice,
    required this.totalPay,
    required this.dateTransaction,
  });
}
