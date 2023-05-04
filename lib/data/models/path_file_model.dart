import 'package:main_cashier/data/datasource/local/drift/drift_database.dart';

import '../../domain/entity/path_file_entity.dart';

class PathFileModel extends PathFileEntity {
  PathFileModel({
    required super.folder,
    required super.path,
  });

  PathFileTableData toTable(PathFileModel pathFileModel) {
    return PathFileTableData(
      folder: pathFileModel.folder,
      path: pathFileModel.path,
    );
  }

  factory PathFileModel.fromTable(PathFileTableData data) {
    return PathFileModel(
      folder: data.folder,
      path: data.path,
    );
  }

  static List<PathFileModel> fromTableList(List<PathFileTableData> data) {
    if (data.isEmpty) return [];
    return data.map((val) => PathFileModel.fromTable(val)).toList();
  }
}
