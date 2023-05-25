import 'drift/drift_database.dart';
import '../../models/color_app_model.dart';

abstract class ColorAppLocalDataSource {
  Future<ColorAppModel> get();
  Future<bool> update(ColorAppModel colorAppModel);
}

class ColorAppLocalDataSourceImpl implements ColorAppLocalDataSource {
  final DatabaseApp databaseApp;

  ColorAppLocalDataSourceImpl({
    required this.databaseApp,
  });

  @override
  Future<ColorAppModel> get() async {
    return ColorAppModel.fromTable(
      await databaseApp.select(databaseApp.colorAppTable).getSingle(),
    );
  }

  @override
  Future<bool> update(ColorAppModel colorAppModel) async {
    return await databaseApp.update(databaseApp.colorAppTable).replace(
          colorAppModel.toTable(colorAppModel),
        );
  }
}
