import 'package:flutter/material.dart';
import 'package:main_cashier/core/constant/color_constant.dart';
import 'package:main_cashier/presentation/home/home_controller.dart';

import '../../../core/constant/list_constant.dart';
import 'menu_sidebar.dart';

class Sidebar extends StatelessWidget {
  final HomeController homeController;

  const Sidebar({
    required this.homeController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: canvasColor,
        elevation: 0.2,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // DrawerHeader(
              //   decoration: const BoxDecoration(color: Colors.transparent),
              //   child: Image.asset(
              //     'assets/images/logo_apps.png',
              //     width: 80,
              //   ),
              // ),
              Column(
                children: listTabMenu
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
