import 'dart:io';
import 'drift/drift_database.dart';

abstract class BackupLocalDataSource {
  Future<void> export(File file);
}

class BackupLocalDataSourceImpl implements BackupLocalDataSource {
  final DatabaseApp databaseApp;

  BackupLocalDataSourceImpl({
    required this.databaseApp,
  });
  @override
  Future<void> export(File file) async {
    await databaseApp.customStatement('VACUUM INTO ?', [file.path]);
  }
}
