import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  late TabController tabControllerHome;

  int _indexTabActive = 0;
  int get indexTabActive => _indexTabActive;

  bool _isSidebarExpanded = false;
  bool get isSidebarExpanded => _isSidebarExpanded;

  void toogleSidebar(bool expand) {
    _isSidebarExpanded = expand;
    // notifyListeners();
  }

  void changeIndexTab(int index) {
    _indexTabActive = index;
    tabControllerHome.index = index;
    notifyListeners();
  }
}
