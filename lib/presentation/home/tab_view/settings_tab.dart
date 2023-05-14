import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:main_cashier/color_app.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../core/utils/dialog_utils.dart';
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

    controller.initColorApp();
    controller.initPathFolder();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SettingsTabController>();
    final colorApp = context.watch<ColorApp>();

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
                                colorApp.setColorApp();
                                navigator.pop();
                              },
                              callbackCancel: () => navigator.pop(),
                            );
                          },
                        );
                      },
                      child: Text(
                        "Reset",
                        style: TextStyle(color: colorApp.primary),
                      ),
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
                                colorApp.setColorApp();
                                navigator.pop();
                              },
                              callbackCancel: () => navigator.pop(),
                            );
                          },
                        );
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(color: colorApp.primary),
                      ),
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
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Path Folder",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: const Text(
                  "Invoice",
                  style: TextStyle(fontSize: 14),
                ),
                subtitle: Text(
                  controller.defaultPathInvoice,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                trailing: InkWell(
                  onTap: () {
                    controller.changeTypePath(0);
                    controller.setFolder(
                      controller.defaultPathInvoice,
                    );

                    showDialog(
                      context: context,
                      builder: (context) => const Dialog(
                        child: DialogOpenFolder(),
                      ),
                    );
                  },
                  child: const Icon(UniconsLine.folder),
                ),
              ),
              ListTile(
                title: const Text(
                  "Report",
                  style: TextStyle(fontSize: 14),
                ),
                subtitle: Text(
                  controller.defaultPathReport,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                trailing: InkWell(
                  onTap: () {
                    controller.changeTypePath(1);
                    controller.setFolder(
                      controller.defaultPathReport,
                    );

                    showDialog(
                      context: context,
                      builder: (context) => const Dialog(
                        child: DialogOpenFolder(),
                      ),
                    );
                  },
                  child: const Icon(UniconsLine.folder),
                ),
              ),
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
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Backup",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: const Text(
                  "Export",
                  style: TextStyle(fontSize: 14),
                ),
                trailing: InkWell(
                  onTap: () {
                    controller.exportData(
                      () {
                        showDialog(
                          context: context,
                          builder: (context) => DialogUtils.dialogInformation(
                            title: "Export Database",
                            message: "Database export success",
                            callbackConfirmation: () => navigator.pop(),
                          ),
                        );
                      },
                    );
                  },
                  child: const Icon(UniconsLine.export),
                ),
              ),
              ListTile(
                title: const Text(
                  "Import",
                  style: TextStyle(fontSize: 14),
                ),
                trailing: InkWell(
                  onTap: () {
                    controller.changeTypePath(2);
                    controller.setFolder(
                      controller.pathActiveImport,
                    );

                    showDialog(
                      context: context,
                      builder: (context) => const Dialog(
                        child: DialogOpenFolder(),
                      ),
                    );
                  },
                  child: const Icon(UniconsLine.import),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }
}

class DialogOpenFolder extends StatelessWidget {
  const DialogOpenFolder({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SettingsTabController>();
    final colorApp = context.watch<ColorApp>();
    final navigator = Navigator.of(context);

    return DialogUtils.layoutCustomDialog(
      dialogHeaderText: controller.typePath == 2 ? "Pick File" : "Pick Folder",
      childern: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () => controller.backFolder(
                  controller.typePath == 0
                      ? controller.pathActiveInvoice
                      : controller.pathActiveReport,
                ),
                child: const Icon(UniconsLine.arrow_left),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                (controller.typePath == 0)
                    ? controller.pathActiveInvoice
                    : (controller.typePath == 1)
                        ? controller.pathActiveReport
                        : controller.pathActiveImport,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        if (controller.listFileSystem.isEmpty)
          TextButton(
            onPressed: () => controller.backFolder(
              controller.pathActiveInvoice,
            ),
            child: const Text(
              "..",
              textAlign: TextAlign.start,
            ),
          ),
        ...controller.listFileSystem
            .asMap()
            .map(
              (i, value) => MapEntry(
                i,
                WidgetList(fileSystem: value, index: i),
              ),
            )
            .values
            .toList(),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "${controller.typePath == 2 ? "File" : "Folder"} : ${controller.indexActive == null ? "" : controller.splitPathLast(controller.listFileSystem[controller.indexActive!].path)}",
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        ElevatedButton(
          onPressed: () {
            if (controller.typePath == 2) {
              controller.importData();
            } else {
              controller.selectFolder();
            }

            navigator.pop();
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(18),
            backgroundColor: colorApp.primary,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            controller.typePath == 2 ? "Select File" : "Select Folder",
          ),
        )
      ],
      callbackClose: () => navigator.pop(),
    );
  }
}

class WidgetList extends StatelessWidget {
  final int index;
  final FileSystemEntity fileSystem;
  const WidgetList({required this.fileSystem, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SettingsTabController>();
    return InkWell(
      onTap: () {
        controller.setIndexActive(index);
      },
      onDoubleTap: () {
        if (fileSystem.statSync().type is Directory) {
          controller.openFolder(
            index,
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color:
              controller.indexActive != null && controller.indexActive == index
                  ? backgroundColor
                  : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              fileSystem.statSync().type is Directory
                  ? UniconsLine.folder
                  : UniconsLine.file,
              size: 24,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(controller.splitPathLast(fileSystem.path)),
          ],
        ),
      ),
    );
  }
}
