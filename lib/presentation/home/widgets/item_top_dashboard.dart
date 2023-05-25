import 'package:flutter/material.dart';
import 'package:main_cashier/color_app.dart';
import 'package:provider/provider.dart';

class ItemTopDashboard extends StatelessWidget {
  final String title;
  final String desc;
  final String value;
  final IconData icon;

  const ItemTopDashboard({
    required this.title,
    required this.value,
    required this.desc,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorApp = context.watch<ColorApp>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: colorApp.primary,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          desc,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
