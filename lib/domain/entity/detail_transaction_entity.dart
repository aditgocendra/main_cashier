class DetailTransactionEntity {
  int id;
  int qty;
  int total;
  String idProduct;

  DetailTransactionEntity({
    required this.id,
    required this.qty,
    required this.total,
    required this.idProduct,
  });
}

class DetailTransactionViewEntity {
  String code;
  String name;
  int sellPrice;
  int qty;
  int total;

  DetailTransactionViewEntity({
    required this.code,
    required this.name,
    required this.sellPrice,
    required this.qty,
    required this.total,
  });
}
