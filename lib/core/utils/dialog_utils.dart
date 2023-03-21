import 'package:flutter/material.dart';

class DialogUtils {
  static Dialog dialogConfirmation({
    required String title,
    required String message,
    required VoidCallback callbackConfirmation,
    required VoidCallback callbackCancel,
  }) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              message,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () => callbackCancel.call(),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () => callbackConfirmation.call(),
                  child: const Text("Confirm"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
