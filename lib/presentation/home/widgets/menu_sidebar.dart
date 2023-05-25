import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../color_app.dart';
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
    final colorApp = context.watch<ColorApp>();
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
                color: _setColorActive(
                  homeController.indexTabActive,
                  indexTab,
                  colorApp.primary,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                menu['menu'],
                style: TextStyle(
                  color: _setColorActive(
                    homeController.indexTabActive,
                    indexTab,
                    colorApp.primary,
                  ),
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
                color: _setColorActive(
                  homeController.indexTabActive,
                  indexTab,
                  colorApp.primary,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                menu['menu'],
                style: TextStyle(
                  fontSize: 8.5,
                  color: _setColorActive(
                    homeController.indexTabActive,
                    indexTab,
                    colorApp.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return widget;
  }

  Color _setColorActive(int indexActive, int indexTab, Color primaryColor) {
    if (indexActive == indexTab) return primaryColor;

    return Colors.black;
  }
}
