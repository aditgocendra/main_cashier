import 'package:flutter/material.dart';

import '../../../core/constant/color_constant.dart';
import '../home_controller.dart';

class MenuSidebar extends StatelessWidget {
  final Map<String, dynamic> menu;
  final HomeController homeController;
  final int indexTab;

  const MenuSidebar({
    required this.menu,
    required this.homeController,
    required this.indexTab,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    late Widget widget;

    if (homeController.isSidebarExpanded) {
      widget = InkWell(
        onTap: () {
          homeController.changeIndexTab(indexTab);
        },
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Icon(
                menu['icon'],
                color: homeController.indexTabActive == indexTab
                    ? primaryColor
                    : Colors.black,
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                menu['menu'],
                style: TextStyle(
                  color: homeController.indexTabActive == indexTab
                      ? primaryColor
                      : Colors.black,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      widget = InkWell(
        onTap: () {
          homeController.changeIndexTab(indexTab);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(4),
          child: Column(
            children: [
              Icon(
                menu['icon'],
                size: 18,
                color: homeController.indexTabActive == indexTab
                    ? primaryColor
                    : Colors.black,
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                menu['menu'],
                style: TextStyle(
                  fontSize: 8.5,
                  color: homeController.indexTabActive == indexTab
                      ? primaryColor
                      : Colors.black,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return widget;
  }
}
