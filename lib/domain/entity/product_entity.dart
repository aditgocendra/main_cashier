class ProductEntity {
  String code;
  String name;
  int price;
  int stock;
  int sold;
  int idCategory;
  DateTime createdAt;

  ProductEntity({
    required this.code,
    required this.name,
    required this.price,
    required this.stock,
    required this.sold,
    required this.idCategory,
    required this.createdAt,
  });
}

class ProductViewEntity {
  String code;
  String name;
  int price;
  int stock;
  int sold;
  String titleCategory;

  ProductViewEntity({
    required this.code,
    required this.name,
    required this.price,
    required this.stock,
    required this.sold,
    required this.titleCategory,
  });
}
