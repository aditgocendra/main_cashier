import 'package:main_cashier/data/datasource/local/drift/drift_database.dart';
import 'package:main_cashier/domain/entity/role_entity.dart';

class RoleModel extends RoleEntity {
  RoleModel({
    required super.id,
    required super.name,
  });

  RoleTableData toTable(RoleModel roleModel) {
    return RoleTableData(
      id: roleModel.id,
      name: roleModel.name,
    );
  }

  factory RoleModel.fromTable(RoleTableData data) {
    return RoleModel(
      id: data.id,
      name: data.name,
    );
  }

  static List<RoleModel> fromTableList(List<RoleTableData> data) {
    if (data.isEmpty) return [];
    return data.map((val) => RoleModel.fromTable(val)).toList();
  }
}
