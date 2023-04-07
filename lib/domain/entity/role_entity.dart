class RoleEntity {
  int id;
  String name;

  RoleEntity({
    required this.id,
    required this.name,
  });

  @override
  String toString() {
    return name;
  }

  bool isEqual(RoleEntity entity) {
    return id == entity.id;
  }
}
