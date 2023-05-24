import 'package:flutter/material.dart';
import 'package:main_cashier/color_app.dart';
import 'package:main_cashier/core/utils/format_utils.dart';
import 'package:main_cashier/presentation/home/tab_controller/dashboard_tab_controller.dart';
import 'package:provider/provider.dart';

class BestSellerProduct extends StatelessWidget {
  const BestSellerProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final colorApp = context.watch<ColorApp>();
    final controller = context.watch<DashboardTabController>();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorApp.canvas,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            "Best Seller Product",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          ...controller.bestSellerProduct
              .asMap()
              .map(
                (index, value) => MapEntry(
                  index,
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: colorApp.primary,
                      child: Text(
                        (index + 1).toString(),
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    trailing: Text(
                      "Sold : ${value.sold}",
                      style: const TextStyle(fontSize: 12.5),
                    ),
                    title: Text(
                      value.name,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      FormatUtility.currencyRp(value.sellPrice),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              )
              .values
              .toList(),
        ],
      ),
    );
  }
}
