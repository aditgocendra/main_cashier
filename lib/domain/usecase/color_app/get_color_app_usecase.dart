import '../../../core/usecase/usecase.dart';
import '../../entity/color_app_entity.dart';
import '../../repostitories/color_app_repository.dart';

class GetColorApp implements Usecase<ColorAppEntity, NoParans> {
  final ColorAppRepository repository;

  GetColorApp({
    required this.repository,
  });

  @override
  Future<ColorAppEntity> call(NoParans params) async {
    return await repository.getColorApp();
  }
}
