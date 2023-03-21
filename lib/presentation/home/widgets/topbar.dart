import 'package:flutter/material.dart';
import 'package:main_cashier/presentation/home/home_controller.dart';
import 'package:provider/provider.dart';

import '../../../core/constant/color_constant.dart';
import '../../../core/constant/list_constant.dart';

class Topbar extends StatelessWidget {
  const Topbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = context.read<HomeController>();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: canvasColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            listTabMenu[homeController.indexTabActive]['menu'],
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: const [
                Text('Administrator'),
                SizedBox(
                  width: 16,
                ),
                // Image.asset(
                //   'assets/avatar/pilot.png',
                //   width: 32,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
