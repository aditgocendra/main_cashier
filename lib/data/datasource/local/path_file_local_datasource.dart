import 'package:main_cashier/data/datasource/local/drift/drift_database.dart';
import 'package:main_cashier/data/models/path_file_model.dart';

abstract class PathFileLocalDataSource {
  Future<List<PathFileModel>> getAll();

  Future<PathFileModel> get(String folder);

  Future<bool> update(PathFileModel pathFileModel);
}

class PathFileLocalDataSourceImpl implements PathFileLocalDataSource {
  final DatabaseApp databaseApp;

  PathFileLocalDataSourceImpl({
    required this.databaseApp,
  });

  @override
  Future<PathFileModel> get(String folder) async {
    final r = await (databaseApp.select(databaseApp.pathFileTable)
          ..where((tbl) => tbl.folder.equals(folder)))
        .getSingle();

    return PathFileModel.fromTable(r);
  }

  @override
  Future<List<PathFileModel>> getAll() async {
    final r = await databaseApp.select(databaseApp.pathFileTable).get();
    return PathFileModel.fromTableList(r);
  }

  @override
  Future<bool> update(PathFileModel pathFileModel) async {
    return await databaseApp
        .update(databaseApp.pathFileTable)
        .replace(pathFileModel.toTable(pathFileModel));
  }
}
