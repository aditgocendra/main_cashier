import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class DialogUtils {
  static Dialog dialogConfirmation({
    required String title,
    required String message,
    required Color primary,
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
              textAlign: TextAlign.center,
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
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: primary),
                  ),
                ),
                TextButton(
                  onPressed: () => callbackConfirmation.call(),
                  child: Text(
                    "Confirm",
                    style: TextStyle(color: primary),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  static Dialog dialogInformation({
    required String title,
    required String message,
    required VoidCallback callbackConfirmation,
    required Color primary,
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
            TextButton(
              onPressed: () => callbackConfirmation.call(),
              child: Text(
                "Confirm",
                style: TextStyle(color: primary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Container layoutCustomDialog({
    required String dialogHeaderText,
    required List<Widget> childern,
    required VoidCallback callbackClose,
  }) {
    return Container(
      width: 800,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dialogHeaderText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => callbackClose.call(),
                icon: const Icon(UniconsLine.times_circle),
              )
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          ...childern.map((val) => val).toList(),
        ],
      ),
    );
  }
}
