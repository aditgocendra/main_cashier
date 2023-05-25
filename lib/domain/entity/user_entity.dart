class UserEntity {
  String uid;
  String username;
  String password;
  int roleId;
  DateTime createdAt;

  UserEntity({
    required this.uid,
    required this.username,
    required this.password,
    required this.roleId,
    required this.createdAt,
  });
}

class UserViewEntity {
  String uid;
  String username;
  String roleName;

  UserViewEntity({
    required this.uid,
    required this.username,
    required this.roleName,
  });
}
