import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:main_cashier/core/utils/dialog_utils.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../core/constant/color_constant.dart';
import '../../../core/constant/list_constant.dart';
import '../tab_controller/settings_tab_controller.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  void initState() {
    super.initState();
    final controller = context.read<SettingsTabController>();
    controller.setColorApp();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SettingsTabController>();
    final navigator = Navigator.of(context);

    return ListView(
      children: [
        if (controller.colorApp != null)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: canvasColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Theme",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...listColorApp
                    .asMap()
                    .map(
                      (index, value) => MapEntry(
                        index,
                        ListTile(
                          title: Text(
                            value,
                            style: const TextStyle(fontSize: 14),
                          ),
                          trailing: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Select Color"),
                                    content: BlockPicker(
                                      pickerColor: Color(
                                        controller.colorApp!.getIndex(index),
                                      ),
                                      availableColors: colors,
                                      onColorChanged: (value) {
                                        controller.changeColor(
                                          value.value,
                                          index,
                                        );
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Color(
                                  controller.colorApp!.getIndex(index),
                                ),
                                border: Border.all(color: borderColor),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .values
                    .toList(),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return DialogUtils.dialogConfirmation(
                              title: "Reset Theme Color",
                              message: "Are you sure ?",
                              callbackConfirmation: () {
                                controller.resetDefaultColorApp();
                                navigator.pop();
                              },
                              callbackCancel: () => navigator.pop(),
                            );
                          },
                        );
                      },
                      child: const Text("Reset"),
                    ),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return DialogUtils.dialogConfirmation(
                              title: "Change Theme Color",
                              message: "Are you sure ?",
                              callbackConfirmation: () {
                                controller.changeColorDataApp();
                                navigator.pop();
                              },
                              callbackCancel: () => navigator.pop(),
                            );
                          },
                        );
                      },
                      child: const Text("Save"),
                    ),
                  ],
                )
              ],
            ),
          ),
        const SizedBox(
          height: 24,
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: canvasColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Backup",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text(
                  "Export",
                  style: TextStyle(fontSize: 14),
                ),
                trailing: InkWell(child: Icon(UniconsLine.export)),
              ),
              ListTile(
                title: Text(
                  "Import",
                  style: TextStyle(fontSize: 14),
                ),
                trailing: InkWell(child: Icon(UniconsLine.import)),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: canvasColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              Text(
                "Path Folder",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        )
      ],
    );
  }
}
