import 'package:flutter/material.dart';

import '../../../core/constant/color_constant.dart';

class ItemTopDashboard extends StatelessWidget {
  final Map<String, dynamic> item;

  const ItemTopDashboard({
    required this.item,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item['title'],
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
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
                item['icon'],
                color: primaryColor,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            const Text(
              '80',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Last store added on 23 December 2022',
          style: TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
