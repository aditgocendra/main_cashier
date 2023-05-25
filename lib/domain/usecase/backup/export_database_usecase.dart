import 'dart:io';

import '../../../core/usecase/usecase.dart';
import '../../repostitories/backup_repository.dart';

class ExportDatabase implements Usecase<dynamic, File> {
  final BackupRepository repository;

  ExportDatabase({
    required this.repository,
  });

  @override
  Future call(File params) async {
    return await repository.exportDatabase(params);
  }
}
