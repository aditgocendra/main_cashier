import '../../core/error/exception.dart';
import '../datasource/local/color_app_local_datasource.dart';
import 'package:main_cashier/data/models/color_app_model.dart';
import '../../domain/entity/color_app_entity.dart';
import 'package:main_cashier/domain/repostitories/color_app_repository.dart';

class ColorAppRepositoryImpl implements ColorAppRepository {
  final ColorAppLocalDataSource colorAppLocalDataSource;

  ColorAppRepositoryImpl({
    required this.colorAppLocalDataSource,
  });

  @override
  Future<ColorAppEntity> getColorApp() async {
    try {
      return await colorAppLocalDataSource.get();
    } catch (_) {
      throw DatabaseDriftException("Fail get color app");
    }
  }

  @override
  Future<bool> updateColorApp(ColorAppEntity newColor) async {
    try {
      return await colorAppLocalDataSource.update(ColorAppModel(
        id: newColor.id,
        primary: newColor.primary,
        primaryLight: newColor.primaryLight,
        background: newColor.background,
        canvas: newColor.canvas,
        border: newColor.border,
      ));
    } catch (_) {
      throw DatabaseDriftException("Fail update color app");
    }
  }
}
