import 'package:main_cashier/domain/entity/color_app_entity.dart';

abstract class ColorAppRepository {
  Future<ColorAppEntity> getColorApp();

  Future<bool> updateColorApp(ColorAppEntity newColor);
}
