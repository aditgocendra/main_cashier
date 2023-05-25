import 'package:flutter/material.dart';
import 'package:main_cashier/auth_state.dart';
import 'package:main_cashier/presentation/home/home_controller.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../color_app.dart';
import '../../../core/constant/list_constant.dart';
import '../../../core/utils/dialog_utils.dart';
import 'menu_sidebar.dart';

class Sidebar extends StatelessWidget {
  final HomeController homeController;

  const Sidebar({
    required this.homeController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthState>();
    final colorApp = context.watch<ColorApp>();
    final navigator = Navigator.of(context);
    final sizeScreenWidh = MediaQuery.of(context).size.width;

    if (sizeScreenWidh > 1024) {
      homeController.toogleSidebar(true);
    } else {
      homeController.toogleSidebar(false);
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: homeController.isSidebarExpanded ? 270 : 80,
      ),
      child: Drawer(
        backgroundColor: colorApp.canvas,
        elevation: 0.2,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...listTabMenu
                  .asMap()
                  .map(
                    (index, value) => MapEntry(
                      index,
                      MenuSidebar(
                        menu: value,
                        indexTab: index,
                        homeController: homeController,
                      ),
                    ),
                  )
                  .values
                  .toList(),
              const SizedBox(
                height: 24,
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DialogUtils.dialogConfirmation(
                        title: "Logout",
                        message: "Are you sure ?",
                        primary: colorApp.primary,
                        callbackConfirmation: () async {
                          await authState.logout().then(
                                (_) => navigator.pop(),
                              );
                        },
                        callbackCancel: () => navigator.pop(),
                      );
                    },
                  );
                },
                icon: const Icon(UniconsLine.exit),
              )
            ],
          ),
        ),
      ),
    );
  }
}
