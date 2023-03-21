import 'package:flutter/material.dart';

import '../constant/color_constant.dart';

class DecorationUtils {
  static InputDecoration textFieldDecoration(
    String hint,
  ) {
    return InputDecoration(
      fillColor: Colors.white60,
      hintText: hint,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ),
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
}
