import 'package:flutter/material.dart';
import 'package:main_cashier/core/utils/decoration_utils.dart';
import 'package:main_cashier/core/utils/dialog_utils.dart';
import 'package:unicons/unicons.dart';

import '../../../core/constant/color_constant.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: canvasColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 200,
                  child: TextField(
                    // controller: homeController.searchTec,
                    style: const TextStyle(fontSize: 14),
                    onTap: () {
                      // Change Content View
                      // if (homeController.indexSidebarSelected.value < 2) {
                      //   homeController.indexSidebarSelected.value = 1;
                      //   return;
                      // }

                      // homeController.indexSidebarSelected.value =
                      //     homeController.indexSidebarSelected.value;
                    },
                    onChanged: (value) {
                      // if (value.isEmpty) {
                      //   // homeController.setDataTable();
                      // }
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white60,
                      hintText: "Pencarian",
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
                      suffixIcon: InkWell(
                        onTap: () {
                          // homeController.search();
                        },
                        child: const Icon(
                          UniconsLine.search_alt,
                          color: borderColor,
                          size: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                Wrap(
                  children: [
                    const SizedBox(
                      width: 12,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: DialogCategoryAdd(),
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        backgroundColor: primaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text(
                        "Category Add",
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                SelectionArea(
                  child: Table(
                    border: const TableBorder(
                      horizontalInside: BorderSide(
                        width: 0.1,
                      ),
                      top: BorderSide(
                        width: 0.1,
                      ),
                      bottom: BorderSide(
                        width: 0.1,
                      ),
                    ),
                    columnWidths: const <int, TableColumnWidth>{
                      0: FlexColumnWidth(),
                      1: FlexColumnWidth(),
                      2: FlexColumnWidth(),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: <TableRow>[
                      // Header Data Table
                      const TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(
                                child: Text(
                                  "Category ID",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(
                                child: Text(
                                  "Title",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(
                                child: Text(
                                  "Action",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(
                                child: Text(
                                  "Category ID",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                          const TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(
                                child: Text(
                                  "Title",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Center(
                                child: Wrap(
                                  children: [
                                    // Edit
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(UniconsLine.edit),
                                    ),
                                    // Delete
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return DialogUtils
                                                .dialogConfirmation(
                                              title: "Delete Category",
                                              message:
                                                  "Are you sure delete this category ?",
                                              callbackConfirmation: () {
                                                Navigator.pop(context);
                                              },
                                              callbackCancel: () {
                                                Navigator.pop(context);
                                              },
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(UniconsLine.trash),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Footer
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.keyboard_arrow_left),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.keyboard_arrow_right),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DialogCategoryAdd extends StatelessWidget {
  DialogCategoryAdd({super.key});

  final tecTitle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Category Add",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(UniconsLine.times_circle),
              )
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          TextField(
            controller: tecTitle,
            style: const TextStyle(fontSize: 14),
            onTap: () {
              // Change Content View
              // if (homeController.indexSidebarSelected.value < 2) {
              //   homeController.indexSidebarSelected.value = 1;
              //   return;
              // }

              // homeController.indexSidebarSelected.value =
              //     homeController.indexSidebarSelected.value;
            },
            onChanged: (value) {
              // if (value.isEmpty) {
              //   // homeController.setDataTable();
              // }
            },
            decoration: DecorationUtils.textFieldDecoration("Title"),
          ),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              elevation: 0.5,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              minimumSize: const Size.fromHeight(50),
            ),
            child: const Text("Add"),
          )
        ],
      ),
    );
  }
}
