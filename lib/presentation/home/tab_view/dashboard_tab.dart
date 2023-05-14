import 'package:flutter/material.dart';
import 'package:main_cashier/color_app.dart';
import 'package:main_cashier/core/utils/format_utils.dart';
import 'package:main_cashier/presentation/home/tab_controller/dashboard_tab_controller.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../widgets/item_top_dashboard.dart';

class DashboardTab extends StatefulWidget {
  const DashboardTab({super.key});

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
  @override
  void initState() {
    super.initState();

    final controller = context.read<DashboardTabController>();
    controller.initData();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<DashboardTabController>();
    final colorApp = context.watch<ColorApp>();
    final sizeScreen = MediaQuery.of(context).size;

    double aspectRatio = sizeScreen.width / 780;
    int crossAxisGrid = 4;

    if (sizeScreen.width < 1500) {
      crossAxisGrid = 2;
      aspectRatio = sizeScreen.width / 470;
    }

    if (sizeScreen.width < 1024) {
      aspectRatio = sizeScreen.width / 450;
    }

    if (sizeScreen.width < 770) {
      crossAxisGrid = 1;
      aspectRatio = sizeScreen.width / 350;
    }

    if (sizeScreen.width < 450) {
      aspectRatio = sizeScreen.width / 600;
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: colorApp.canvas,
              borderRadius: BorderRadius.circular(16),
            ),
            child: GridView.count(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(64),
              crossAxisCount: crossAxisGrid,
              childAspectRatio: aspectRatio,
              crossAxisSpacing: 32,
              mainAxisSpacing: 32,
              children: [
                ItemTopDashboard(
                  icon: UniconsLine.archive_alt,
                  title: "Total Product",
                  desc: "Last added product",
                  value: controller.totalProduct.toString(),
                ),
                ItemTopDashboard(
                  icon: UniconsLine.apps,
                  title: "Total Category",
                  desc: "Last added category",
                  value: controller.totalCategory.toString(),
                ),
                ItemTopDashboard(
                  icon: UniconsLine.transaction,
                  title: "Total Transaction",
                  desc: "Last transaction",
                  value: controller.totalTransaction.toString(),
                ),
                ItemTopDashboard(
                  icon: UniconsLine.money_insert,
                  title: "Profit",
                  desc: "Profit this month",
                  value: FormatUtility.currencyRp(controller.profitMonth),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
