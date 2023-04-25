import 'package:main_cashier/data/datasource/local/drift/drift_database.dart';
import 'package:main_cashier/domain/entity/color_app_entity.dart';

class ColorAppModel extends ColorAppEntity {
  ColorAppModel({
    required super.id,
    required super.primary,
    required super.primaryLight,
    required super.background,
    required super.canvas,
    required super.border,
  });

  ColorAppTableData toTable(ColorAppModel colorAppModel) {
    return ColorAppTableData(
      id: colorAppModel.id,
      primary: colorAppModel.primary,
      primaryLight: colorAppModel.primaryLight,
      background: colorAppModel.background,
      canvas: colorAppModel.canvas,
      border: colorAppModel.border,
    );
  }

  factory ColorAppModel.fromTable(ColorAppTableData data) {
    return ColorAppModel(
      id: data.id,
      primary: data.primary,
      primaryLight: data.primaryLight,
      background: data.background,
      canvas: data.canvas,
      border: data.border,
    );
  }
}
