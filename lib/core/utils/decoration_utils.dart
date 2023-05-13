import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../constant/color_constant.dart';

class DecorationUtils {
  static InputDecoration textFieldDecoration({
    required String hint,
    required String label,
  }) {
    return InputDecoration(
      fillColor: Colors.white60,
      hintText: hint,
      label: Text(label),
      floatingLabelAlignment: FloatingLabelAlignment.start,
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          color: borderColor,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
    );
  }

  static DropDownDecoratorProps dropdownStyleForm(String labelText) {
    return DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
        contentPadding: const EdgeInsets.all(12.0),
        border: const OutlineInputBorder(
          borderSide: BorderSide(width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1.0, color: Colors.blue),
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 14),
      ),
    );
  }

  static ButtonStyle buttonDialogStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
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
