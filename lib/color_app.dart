import 'package:flutter/material.dart';
import 'package:main_cashier/core/constant/color_constant.dart';
import 'core/usecase/usecase.dart';
import 'domain/entity/color_app_entity.dart';
import 'domain/usecase/color_app/get_color_app_usecase.dart';

class ColorApp extends ChangeNotifier {
  ColorAppEntity? _color;

  final GetColorApp getColorApp;

  ColorApp({
    required this.getColorApp,
  }) {
    setColorApp();
  }

  void setColorApp() async {
    await getColorApp.call(NoParans()).then((value) {
      _color = value;
      notifyListeners();
    });
  }

  Color get primary => _color == null ? primaryColor : Color(_color!.primary);

  Color get primaryLight =>
      _color == null ? primaryLightColor : Color(_color!.primaryLight);

  Color get background =>
      _color == null ? backgroundColor : Color(_color!.background);

  Color get canvas => _color == null ? canvasColor : Color(_color!.canvas);

  Color get border => _color == null ? borderColor : Color(_color!.border);
}
