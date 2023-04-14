import 'package:flutter/material.dart';

import '../../../core/constant/color_constant.dart';
import '../../../core/constant/list_constant.dart';
import '../widgets/item_top_dashboard.dart';

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
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
              color: canvasColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: GridView.builder(
              primary: false,
              shrinkWrap: true,
              padding: const EdgeInsets.all(64),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisGrid,
                childAspectRatio: aspectRatio,
                crossAxisSpacing: 32,
                mainAxisSpacing: 32,
              ),
              itemCount: listCardTop.length,
              itemBuilder: (context, index) {
                return ItemTopDashboard(
                  item: listCardTop[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
