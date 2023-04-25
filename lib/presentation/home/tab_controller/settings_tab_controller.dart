import 'package:flutter/material.dart';
import '../../../core/constant/color_constant.dart';
import '../../../core/usecase/usecase.dart';
import '../../../domain/entity/color_app_entity.dart';
import '../../../domain/usecase/color_app/get_color_app_usecase.dart';
import '../../../domain/usecase/color_app/update_color_app_usecase.dart';

class SettingsTabController extends ChangeNotifier {
  ColorAppEntity? _colorApp;
  ColorAppEntity? get colorApp => _colorApp;

  // Usecase
  final GetColorApp getColorApp;
  final UpdateColorApp updateColorApp;

  SettingsTabController({
    required this.getColorApp,
    required this.updateColorApp,
  });

  void setColorApp() async {
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
}
