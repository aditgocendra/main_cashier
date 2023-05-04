import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

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

  List<String> _listDir = [];
  List<String> get listDir => _listDir;

  int? _indexActiveFolder = null;
  int? get indexActiveFolder => _indexActiveFolder;

  ColorAppEntity? _colorApp;
  ColorAppEntity? get colorApp => _colorApp;

  bool _typePath = false;
  bool get typePath => _typePath;

  // Usecase
  final GetColorApp getColorApp;
  final UpdateColorApp updateColorApp;
  final GetPathFile getPathFile;
  final UpdatePathFile updatePathFile;

  SettingsTabController({
    required this.getColorApp,
    required this.updateColorApp,
    required this.getPathFile,
    required this.updatePathFile,
  });

  void initColorApp() async {
    await getColorApp.call(NoParans()).then((value) {
      _colorApp = value;
      notifyListeners();
    }).catchError((e) {
      print(e.toString());
    });
  }

  void changeColorDataApp() async {
    await updateColorApp.call(colorApp!).then((value) {
      if (!value) return;
    }).catchError((e) {
      print(e.toString());
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
    }).catchError((e) => print);

    await getPathFile.call("report").then((value) async {
      defaultPathReport = value.path;
    }).catchError((e) => print);
  }

  void setIndexActiveFolder(int index) {
    _indexActiveFolder = index;
    notifyListeners();
  }

  // typePath == true ? invoice : report
  void changeTypePath(bool newType) => _typePath = newType;

  void setFolder(
    String pathActive,
  ) async {
    listDir.clear();
    _listDir = _getPathFolder(pathActive);

    typePath ? _pathActiveInvoice = pathActive : _pathActiveReport = pathActive;

    notifyListeners();
  }

  void openFolder(int index) {
    _indexActiveFolder = null;

    final newActivePath = path.join(
      typePath ? pathActiveInvoice : pathActiveReport,
      listDir[index],
    );

    listDir.clear();

    typePath
        ? _pathActiveInvoice = newActivePath
        : _pathActiveReport = newActivePath;
    _listDir = _getPathFolder(newActivePath);

    notifyListeners();
  }

  void backFolder(String pathActive) {
    _indexActiveFolder = null;
    final r = path.split(pathActive);

    if (r.length <= 1) return;

    r.removeLast();

    listDir.clear();
    _pathActiveInvoice = path.joinAll(r);

    typePath
        ? _pathActiveInvoice = path.joinAll(r)
        : _pathActiveReport = path.joinAll(r);

    _listDir = _getPathFolder(path.joinAll(r));

    notifyListeners();
  }

  List<String> _getPathFolder(String pathDir) {
    List<String> list = [];
    final dirs = Directory(pathDir).listSync().where(
          (element) => element is Directory && element.statSync().mode != 16749,
        );

    for (var element in dirs) {
      try {
        Directory(element.path).listSync();
        list.add(path.split(element.path).last);
      } catch (_) {
        continue;
      }
    }

    return list;
  }

  void selectFolderInvoice() async {
    if (typePath) {
      if (indexActiveFolder == null || pathActiveInvoice.isEmpty) return;
    } else {
      if (indexActiveFolder == null || pathActiveReport.isEmpty) return;
    }

    final newPath = path.join(
      typePath ? pathActiveInvoice : pathActiveReport,
      listDir[indexActiveFolder!],
    );

    final params = PathFileEntity(
      folder: typePath ? "invoice" : "report",
      path: newPath,
    );

    await updatePathFile.call(params).then((value) {
      if (!value) return;
      typePath ? defaultPathInvoice = newPath : defaultPathReport = newPath;
      _indexActiveFolder = null;
      notifyListeners();
    }).catchError((e) {
      print(e.toString());
    });
  }
}
