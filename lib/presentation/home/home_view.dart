import 'package:flutter/material.dart';
import 'tab_view/category_tab.dart';
import 'tab_view/inventory_tab.dart';
import '../../core/constant/list_constant.dart';
import 'home_controller.dart';
import 'tab_view/dashboard_tab.dart';
import 'widgets/sidebar.dart';
import 'package:provider/provider.dart';

import 'widgets/topbar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeController>();

    return Scaffold(
      body: Row(
        children: [
          Sidebar(homeController: controller),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Topbar(),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: TabScreen(controller: controller),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TabScreen extends StatefulWidget {
  final HomeController controller;
  const TabScreen({
    required this.controller,
    super.key,
  });

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    widget.controller.tabControllerHome = TabController(
      length: listTabMenu.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: widget.controller.tabControllerHome,
      children: const [
        DashboardTab(),
        InventoryTab(),
        CategoryTab(),
        Center(
          child: Text('4'),
        ),
        Center(
          child: Text('5'),
        ),
      ],
    );
  }
}
