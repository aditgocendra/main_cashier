import 'package:flutter/material.dart';
import 'package:main_cashier/domain/usecase/login_info/delete_login_info_usecase.dart';
import '../../core/usecase/usecase.dart';
import '../../domain/usecase/user/get_total_user_usecase.dart';

class HomeController extends ChangeNotifier {
  late TabController tabControllerHome;

  int _indexTabActive = 0;
  int get indexTabActive => _indexTabActive;

  bool _isSidebarExpanded = false;
  bool get isSidebarExpanded => _isSidebarExpanded;

  final GetTotalUser getTotalUser;
  final DeleteLoginInfo deleteLoginInfo;

  HomeController({
    required this.getTotalUser,
    required this.deleteLoginInfo,
  });

  Future checkUsers({
    required VoidCallback callbackUserNotExist,
  }) async {
    await getTotalUser.call(NoParans()).then((value) {
      if (value == null || value == 0) {
        callbackUserNotExist.call();
      }
    });
  }

  void toogleSidebar(bool expand) => _isSidebarExpanded = expand;

  void changeIndexTab(int index) {
    _indexTabActive = index;
    tabControllerHome.index = index;
    notifyListeners();
  }

  void signOut(VoidCallback callback) async {
    await deleteLoginInfo.call('asd').then((value) {
      callback.call();
    });
  }

  void test(VoidCallback callback) {
    callback.call();
  }
}
