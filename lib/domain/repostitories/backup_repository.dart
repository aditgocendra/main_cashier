import 'dart:io';

abstract class BackupRepository {
  Future<void> exportDatabase(File file);
}
