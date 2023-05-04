import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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
                    controller.changeTypePath(true);
                    controller.setFolder(
                      controller.defaultPathInvoice,
                    );

                    showDialog(
                      context: context,
                      builder: (context) => const Dialog(
                        child: DialogSelectFolder(),
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
                    controller.changeTypePath(false);
                    controller.setFolder(
                      controller.defaultPathReport,
                    );

                    showDialog(
                      context: context,
                      builder: (context) => const Dialog(
                        child: DialogSelectFolder(),
                      ),
                    );
                  },
                  child: const Icon(UniconsLine.folder),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class DialogSelectFolder extends StatelessWidget {
  const DialogSelectFolder({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SettingsTabController>();
    final navigator = Navigator.of(context);

    return DialogUtils.layoutCustomDialog(
      dialogHeaderText: "Pick Folder",
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
                onTap: () =>
                    controller.backFolder(controller.pathActiveInvoice),
                child: const Icon(UniconsLine.arrow_left),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                controller.typePath
                    ? controller.pathActiveInvoice
                    : controller.pathActiveReport,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        if (controller.listDir.isEmpty)
          TextButton(
            onPressed: () => controller.backFolder(
              controller.pathActiveInvoice,
            ),
            child: const Text(
              "..",
              textAlign: TextAlign.start,
            ),
          ),
        ...controller.listDir
            .asMap()
            .map(
              (i, value) => MapEntry(
                i,
                InkWell(
                  onTap: () => controller.setIndexActiveFolder(i),
                  onDoubleTap: () {
                    controller.openFolder(
                      i,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: controller.indexActiveFolder != null &&
                              controller.indexActiveFolder == i
                          ? backgroundColor
                          : Colors.transparent,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          UniconsLine.folder,
                          size: 24,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(value),
                      ],
                    ),
                  ),
                ),
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
            "Folder : ${controller.indexActiveFolder == null ? "" : controller.listDir[controller.indexActiveFolder!]}",
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        ElevatedButton(
          onPressed: () {
            controller.selectFolderInvoice();
            navigator.pop();
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(18),
            backgroundColor: primaryColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text("Select Folder"),
        )
      ],
      callbackClose: () => navigator.pop(),
    );
  }
}
