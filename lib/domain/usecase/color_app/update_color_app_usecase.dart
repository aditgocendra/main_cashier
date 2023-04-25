import 'package:main_cashier/core/usecase/usecase.dart';
import 'package:main_cashier/domain/entity/color_app_entity.dart';
import 'package:main_cashier/domain/repostitories/color_app_repository.dart';

class UpdateColorApp implements Usecase<bool, ColorAppEntity> {
  final ColorAppRepository repository;

  UpdateColorApp({
    required this.repository,
  });

  @override
  Future<bool> call(ColorAppEntity params) async {
    return await repository.updateColorApp(params);
  }
}
