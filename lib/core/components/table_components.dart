import 'package:flutter/material.dart';

class TableComponent {
  static TableCell _headerComponent(String text) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  static TableRow headerTable(List<String> headerText) {
    return TableRow(
      children: headerText.map((val) {
        return _headerComponent(val);
      }).toList(),
    );
  }
}
