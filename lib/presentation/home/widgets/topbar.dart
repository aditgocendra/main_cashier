import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../color_app.dart';
import '../home_controller.dart';

import '../../../core/constant/color_constant.dart';
import '../../../core/constant/list_constant.dart';

class Topbar extends StatelessWidget {
  const Topbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = context.watch<HomeController>();
    final colorApp = context.watch<ColorApp>();
    final sizeWidthScreen = MediaQuery.of(context).size.width;

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
            style: TextStyle(
                fontSize: sizeWidthScreen > 360 ? 24 : 16,
                fontWeight: FontWeight.bold),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                color: colorApp.border,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                if (sizeWidthScreen > 475)
                  const Text("@aditgocendra"
                      // authState.userEntity == null
                      //     ? ""
                      //     : FormatUtility.capitalize(
                      //         authState.userEntity!.username,
                      //       ),
                      ),
                if (sizeWidthScreen > 475) const SizedBox(width: 8),
                Image.asset(
                  'assets/images/admin_avatar.png',
                  width: sizeWidthScreen > 360 ? 32 : 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
