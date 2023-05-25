class CategoryEntity {
  int id;
  String title;
  DateTime createdAt;

  CategoryEntity({
    required this.id,
    required this.title,
    required this.createdAt,
  });

  @override
  String toString() {
    return title;
  }

  bool isEqual(CategoryEntity entity) {
    return id == entity.id;
  }
}
