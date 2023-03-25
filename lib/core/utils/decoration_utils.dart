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
          Radius.circular(12),
        ),
      ),
    );
  }

  static ButtonStyle buttonDialogStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      elevation: 0.5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      minimumSize: const Size.fromHeight(50),
    );
  }
}
