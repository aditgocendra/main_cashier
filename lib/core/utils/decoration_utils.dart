import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class DecorationUtils {
  static InputDecoration textFieldDecoration({
    required String hint,
    required String label,
  }) {
    return InputDecoration(
      fillColor: Colors.white60,
      hintText: hint,
      label: Text(label),
    );
  }

  static DropDownDecoratorProps dropdownStyleForm(String labelText) {
    return DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
        contentPadding: const EdgeInsets.all(12.0),
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 14),
      ),
    );
  }

  static ButtonStyle buttonDialogStyle(Color backgroundColor) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      elevation: 0.5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      minimumSize: const Size.fromHeight(60),
    );
  }
}
