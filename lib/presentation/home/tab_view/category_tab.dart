import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../core/constant/values_constant.dart';
import '../../../core/components/table_components.dart';
import '../../../core/utils/decoration_utils.dart';
import '../../../core/utils/dialog_utils.dart';
import '../../../core/constant/color_constant.dart';
import '../../../domain/entity/category_entity.dart';

import '../tab_controller/category_tab_controller.dart';

class CategoryTab extends StatefulWidget {
  const CategoryTab({super.key});

  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryTabController>().setCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final ctgTabController = context.watch<CategoryTabController>();

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
                    onChanged: (value) {},
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
                        onTap: () {},
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
                              child: DialogCategoryAdd(
                                ctgTabController: ctgTabController,
                              ),
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
                      TableComponent.headerTable(
                        ["Category ID", "Title", "Action"],
                      ),
                      // Body Data Table
                      ...ctgTabController.listCategory.map((val) {
                        return TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Center(
                                  child: Text(
                                    val.id.toString(),
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Center(
                                  child: Text(
                                    val.title,
                                    style: const TextStyle(fontSize: 14),
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
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Dialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: DialogCategoryEdit(
                                                  ctg: val,
                                                  ctgTabController:
                                                      ctgTabController,
                                                ),
                                              );
                                            },
                                          );
                                        },
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
                                                  ctgTabController
                                                      .removeCategory(val);

                                                  if (ctgTabController
                                                      .errorDialog
                                                      .isNotEmpty) {}
                                                  navigator.pop();
                                                },
                                                callbackCancel: () {
                                                  navigator.pop();
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
                        );
                      }).toList()
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
  final TextEditingController tecTitle = TextEditingController();
  final CategoryTabController ctgTabController;

  DialogCategoryAdd({required this.ctgTabController, super.key});

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final formKey = GlobalKey<FormState>();

    return DialogUtils.layoutCustomDialog(
      dialogHeaderText: "Category Add",
      childern: [
        Form(
          key: formKey,
          child: TextFormField(
            controller: tecTitle,
            validator: (title) {
              if (title == null || title.isEmpty) {
                return fieldRequired;
              }

              return null;
            },
            style: const TextStyle(fontSize: 14),
            decoration: DecorationUtils.textFieldDecoration(
              label: "Title",
              hint: "Example : Accesoris",
            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        ElevatedButton(
          onPressed: () {
            if (!formKey.currentState!.validate()) {
              return;
            }

            ctgTabController.addCategory(tecTitle.text);
            navigator.pop();

            if (ctgTabController.errorDialog.isNotEmpty) {
              showDialog(
                context: context,
                builder: (context) => DialogUtils.dialogInformation(
                  title: "Edit Category",
                  message: ctgTabController.errorDialog,
                  callbackConfirmation: () => navigator.pop(),
                ),
              );
              ctgTabController.resetErrorDialog();
            }
          },
          style: DecorationUtils.buttonDialogStyle(),
          child: const Text("Add"),
        ),
      ],
      callbackClose: () {
        navigator.pop();
      },
    );
  }
}

class DialogCategoryEdit extends StatelessWidget {
  final TextEditingController tecTitle = TextEditingController();

  final CategoryTabController ctgTabController;
  final CategoryEntity ctg;

  DialogCategoryEdit({
    required this.ctgTabController,
    required this.ctg,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final formKey = GlobalKey<FormState>();

    tecTitle.text = ctg.title;

    return DialogUtils.layoutCustomDialog(
      dialogHeaderText: "Category Edit",
      childern: [
        Form(
          key: formKey,
          child: TextFormField(
            controller: tecTitle,
            validator: (title) {
              if (title == null || title.isEmpty) {
                return fieldRequired;
              }
              return null;
            },
            style: const TextStyle(fontSize: 14),
            decoration: DecorationUtils.textFieldDecoration(
              label: "Title",
              hint: "Example : Accesoris",
            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        ElevatedButton(
          onPressed: () {
            if (!formKey.currentState!.validate()) {
              return;
            }

            ctg.title = tecTitle.text;
            ctgTabController.updateCategory(ctg);

            navigator.pop();

            if (ctgTabController.errorDialog.isNotEmpty) {
              showDialog(
                context: context,
                builder: (context) => DialogUtils.dialogInformation(
                  title: "Edit Category",
                  message: ctgTabController.errorDialog,
                  callbackConfirmation: () => navigator.pop(),
                ),
              );

              ctgTabController.resetErrorDialog();
            }
          },
          style: DecorationUtils.buttonDialogStyle(),
          child: const Text("Edit"),
        ),
      ],
      callbackClose: () => navigator.pop(),
    );
  }
}
