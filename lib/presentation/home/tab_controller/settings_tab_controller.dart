import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:main_cashier/domain/usecase/backup/export_database_usecase.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../core/constant/color_constant.dart';
import '../../../core/usecase/usecase.dart';
import '../../../domain/entity/path_file_entity.dart';
import '../../../domain/entity/color_app_entity.dart';
import '../../../domain/usecase/color_app/get_color_app_usecase.dart';
import '../../../domain/usecase/color_app/update_color_app_usecase.dart';
import '../../../domain/usecase/path_file/get_path_file_usecase.dart';
import '../../../domain/usecase/path_file/update_path_file_usecase.dart';

class SettingsTabController extends ChangeNotifier {
  String defaultPathInvoice = "";
  String defaultPathReport = "";

  String _pathActiveInvoice = "";
  String get pathActiveInvoice => _pathActiveInvoice;

  String _pathActiveReport = "";
  String get pathActiveReport => _pathActiveReport;

  String _pathActiveImport = "";
  String get pathActiveImport => _pathActiveImport;

  List<FileSystemEntity> _listFileSystem = [];
  List<FileSystemEntity> get listFileSystem => _listFileSystem;

  int? _indexActive;
  int? get indexActive => _indexActive;

  ColorAppEntity? _colorApp;
  ColorAppEntity? get colorApp => _colorApp;

  // 0 = Invoice
  // 1 = Report
  // 2 = Import
  int _typePath = 0;
  int get typePath => _typePath;

  // Usecase
  final GetColorApp getColorApp;
  final UpdateColorApp updateColorApp;
  final GetPathFile getPathFile;
  final UpdatePathFile updatePathFile;
  final ExportDatabase exportDatabase;

  SettingsTabController({
    required this.getColorApp,
    required this.updateColorApp,
    required this.getPathFile,
    required this.updatePathFile,
    required this.exportDatabase,
  });

  void initColorApp() async {
    await getColorApp.call(NoParans()).then((value) {
      _colorApp = value;
      notifyListeners();
    });
  }

  void changeColorDataApp() async {
    await updateColorApp.call(colorApp!).then((value) {
      if (!value) return;
    });
  }

  void resetDefaultColorApp() {
    _colorApp!.primary = primaryColor.value;
    _colorApp!.primaryLight = primaryLightColor.value;
    _colorApp!.background = backgroundColor.value;
    _colorApp!.canvas = canvasColor.value;
    _colorApp!.border = borderColor.value;

    changeColorDataApp();
    notifyListeners();
  }

  void changeColor(int newColor, int index) {
    switch (index) {
      case 0:
        _colorApp!.primary = newColor;
        break;
      case 1:
        _colorApp!.primaryLight = newColor;
        break;
      case 2:
        _colorApp!.background = newColor;
        break;
      case 3:
        _colorApp!.canvas = newColor;
        break;
      case 4:
        _colorApp!.border = newColor;
        break;
    }
    notifyListeners();
  }

  void initPathFolder() async {
    await getPathFile.call("invoice").then((value) async {
      defaultPathInvoice = value.path;
    });

    await getPathFile.call("report").then((value) async {
      defaultPathReport = value.path;
    });

    final dir = await getApplicationDocumentsDirectory();
    _pathActiveImport = dir.path;
  }

  void setIndexActive(int index) {
    _indexActive = index;
    notifyListeners();
  }

  // typePath == true ? invoice : report
  void changeTypePath(int newType) => _typePath = newType;

  void setFolder(
    String pathActive,
  ) async {
    _indexActive = null;
    _listFileSystem.clear();
    _listFileSystem = _getFileSystems(pathActive);

    switch (typePath) {
      case 1:
        _pathActiveReport = pathActive;
        break;
      case 2:
        _pathActiveImport = pathActive;
        break;
      default:
        _pathActiveInvoice = pathActive;
        break;
    }

    notifyListeners();
  }

  void openFolder(int index) {
    _indexActive = null;

    final newActivePath = path.join(
      (typePath == 0)
          ? pathActiveInvoice
          : (typePath == 1)
              ? pathActiveReport
              : pathActiveReport,
      splitPathLast(listFileSystem[index].path),
    );

    (typePath == 0)
        ? _pathActiveInvoice = newActivePath
        : (typePath == 1)
            ? _pathActiveReport = newActivePath
            : _pathActiveImport = newActivePath;

    _listFileSystem = _getFileSystems(newActivePath);

    notifyListeners();
  }

  void backFolder(String pathActive) {
    _indexActive = null;
    final r = path.split(pathActive);

    if (r.length <= 1) return;

    r.removeLast();

    final pathJoin = path.joinAll(r);
    _pathActiveInvoice = pathJoin;

    (typePath == 0)
        ? _pathActiveInvoice = pathJoin
        : (typePath == 1)
            ? _pathActiveReport = pathJoin
            : _pathActiveImport = pathJoin;

    _listFileSystem = _getFileSystems(pathJoin);

    notifyListeners();
  }

  List<FileSystemEntity> _getFileSystems(String pathDir) {
    List<FileSystemEntity> list = [];

    final dirs = Directory(pathDir).listSync().where(
          (element) => element.statSync().mode != 16749,
        );

    for (var element in dirs) {
      if (element is Directory) {
        try {
          Directory(element.path).listSync();
          list.add(element);
        } catch (_) {
          continue;
        }
      }

      if (path.extension(element.path) == ".db") {
        list.add(element);
      }
    }
    return list;
  }

  String splitPathLast(String e) {
    return path.split(e).last;
  }

  void selectFolder() async {
    if (typePath == 0) {
      if (indexActive == null || pathActiveInvoice.isEmpty) return;
    } else {
      if (indexActive == null || pathActiveReport.isEmpty) return;
    }

    final newPath = path.join(
      typePath == 0 ? pathActiveInvoice : pathActiveReport,
      listFileSystem[indexActive!].path,
    );

    if (!FileSystemEntity.isDirectorySync(newPath)) return;

    final params = PathFileEntity(
      folder: typePath == 0 ? "invoice" : "report",
      path: newPath,
    );

    await updatePathFile.call(params).then((value) {
      if (!value) return;

      typePath == 0
          ? defaultPathInvoice = newPath
          : defaultPathReport = newPath;
      _indexActive = null;

      notifyListeners();
    });
  }

  void exportData(VoidCallback callback) async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final dateTime = DateTime.now();
    final fileNameBackup =
        'backup_${dateTime.year}${dateTime.day}${dateTime.month}_${dateTime.hour}${dateTime.minute}${dateTime.millisecond}.db';

    final file = File(path.join(dbFolder.path, fileNameBackup));

    await file.parent.create(recursive: true);

    if (file.existsSync()) file.deleteSync();

    await exportDatabase.call(file).then((value) {
      callback.call();
    });
  }

  void importData(VoidCallback callbackNotFile) async {
    final dbFolder = await getApplicationSupportDirectory();

    final fileBackup = File(path.join(
      pathActiveImport,
      splitPathLast(listFileSystem[indexActive!].path),
    ));

    // Check selection user if is not file
    if (!FileSystemEntity.isFileSync(fileBackup.path)) {
      callbackNotFile.call();
      return;
    }

    final file = File(path.join(dbFolder.path, 'app.db'));

    Uint8List bytes = fileBackup.readAsBytesSync();

    ByteData blob = ByteData.view(bytes.buffer);
    final buffer = blob.buffer;

    await file.writeAsBytes(
      buffer.asUint8List(blob.offsetInBytes, blob.lengthInBytes),
    );
  }
}
