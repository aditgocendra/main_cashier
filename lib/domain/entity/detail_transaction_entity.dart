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
  int price;
  int qty;
  int total;

  DetailTransactionViewEntity({
    required this.code,
    required this.name,
    required this.price,
    required this.qty,
    required this.total,
  });
}
