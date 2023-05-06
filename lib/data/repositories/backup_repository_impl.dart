import 'dart:io';

import 'package:main_cashier/core/error/exception.dart';
import 'package:main_cashier/data/datasource/local/backup_local_datasource.dart';
import 'package:main_cashier/domain/repostitories/backup_repository.dart';

class BackupRepositoryImpl implements BackupRepository {
  final BackupLocalDataSource backupLocalDataSource;

  BackupRepositoryImpl({
    required this.backupLocalDataSource,
  });

  @override
  Future<void> exportDatabase(File file) async {
    try {
      await backupLocalDataSource.export(file);
    } catch (e) {
      throw DatabaseDriftException("Export database fail");
    }
  }
}
