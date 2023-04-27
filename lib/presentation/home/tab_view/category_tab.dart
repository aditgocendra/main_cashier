import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../core/utils/format_utils.dart';
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
  final TextEditingController tecTitle = TextEditingController();
  final TextEditingController tecSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    final ctl = context.read<CategoryTabController>();
    ctl.initTab();
    ctl.setCategories();
  }

  @override
  void dispose() {
    super.dispose();
    tecTitle.dispose();
    tecSearch.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final controller = context.watch<CategoryTabController>();
    final size = MediaQuery.of(context).size.width;

    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        Container(
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
                        controller: tecSearch,
                        style: const TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          fillColor: Colors.white60,
                          hintText: "Search (Title)",
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
                              if (controller.isSearch) {
                                controller.tooggleIsSearch();
                                controller.setCategories();
                                tecSearch.clear();
                                return;
                              }

                              if (tecSearch.text.isEmpty) return;

                              controller.searchDataCategories(
                                tecSearch.text,
                              );
                            },
                            child: Icon(
                              controller.isSearch
                                  ? UniconsLine.times
                                  : UniconsLine.search_alt,
                              size: 20,
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
                                    tecTitle: tecTitle,
                                  ),
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(18),
                            backgroundColor: primaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Create Category",
                            style: TextStyle(fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SelectionArea(
                child: SingleChildScrollView(
                  scrollDirection:
                      size >= 450 ? Axis.vertical : Axis.horizontal,
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
                      0: IntrinsicColumnWidth(),
                      1: IntrinsicColumnWidth(),
                      2: IntrinsicColumnWidth(),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: <TableRow>[
                      // Header Data Table
                      TableComponent.headerTable(
                        ["No", "Title", "Action"],
                      ),
                      // Body Data Table
                      ...controller.listCategory
                          .asMap()
                          .map((index, val) => MapEntry(
                              index,
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          (index + 1).toString(),
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          FormatUtility.capitalize(val.title),
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
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
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                      ),
                                                      child: DialogCategoryEdit(
                                                        ctg: val,
                                                        ctgTabController:
                                                            controller,
                                                        tecTitle: tecTitle,
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              icon:
                                                  const Icon(UniconsLine.edit),
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
                                                          "Are you sure delete this category ?, If there are products in this category, they will be deleted automatically",
                                                      callbackConfirmation: () {
                                                        controller
                                                            .removeCategory(
                                                          val,
                                                        );
                                                        navigator.pop();
                                                      },
                                                      callbackCancel: () {
                                                        navigator.pop();
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                              icon: const Icon(
                                                UniconsLine.trash,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )))
                          .values
                          .toList()
                    ],
                  ),
                ),
              ),
              // Footer
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Text(
                          "Rows per page",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        SizedBox(
                          width: 75,
                          child: DropdownSearch<int>(
                            items: const [10, 25, 50],
                            selectedItem: 10,
                            onChanged: (int? value) {
                              controller.updateRowPage(value!);
                            },
                            popupProps: PopupProps.menu(
                              fit: FlexFit.loose,
                              menuProps: const MenuProps(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ),
                              containerBuilder: (ctx, popupWidget) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Flexible(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12.0),
                                          ),
                                        ),
                                        child: popupWidget,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8.0),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        // Back Page
                        IconButton(
                          onPressed: () {
                            controller.backPage();
                          },
                          icon: const Icon(Icons.keyboard_arrow_left),
                        ),
                        Text(
                          controller.activeRowPage.toString(),
                          style: const TextStyle(
                            fontSize: 12.5,
                          ),
                        ),
                        // Next Page
                        IconButton(
                          onPressed: () {
                            controller.nextPage();
                          },
                          icon: const Icon(Icons.keyboard_arrow_right),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class DialogCategoryAdd extends StatelessWidget {
  final TextEditingController tecTitle;

  const DialogCategoryAdd({
    required this.tecTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CategoryTabController>();
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
            if (!formKey.currentState!.validate()) return;

            controller.addCategory(
              title: tecTitle.text.trim(),
              callbackSuccess: () {
                tecTitle.clear();
                navigator.pop();
              },
              callbackFail: () {
                tecTitle.clear();
                navigator.pop();
                showDialog(
                  context: context,
                  builder: (context) => DialogUtils.dialogInformation(
                    title: "Fail Add Category",
                    message: controller.errorDialog,
                    callbackConfirmation: () => navigator.pop(),
                  ),
                );
              },
            );
          },
          style: DecorationUtils.buttonDialogStyle(),
          child: const Text("Add"),
        ),
      ],
      callbackClose: () {
        tecTitle.clear();
        navigator.pop();
      },
    );
  }
}

class DialogCategoryEdit extends StatelessWidget {
  final TextEditingController tecTitle;
  final CategoryTabController ctgTabController;
  final CategoryEntity ctg;

  const DialogCategoryEdit({
    required this.ctgTabController,
    required this.ctg,
    required this.tecTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final formKey = GlobalKey<FormState>();

    tecTitle.text = FormatUtility.capitalize(ctg.title);

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
            ctgTabController.changeCategory(
              newCtg: ctg,
              callbackSuccess: () {
                tecTitle.clear();
                navigator.pop();
              },
              callbackFail: () {
                navigator.pop();
                showDialog(
                  context: context,
                  builder: (context) => DialogUtils.dialogInformation(
                    title: "Edit Category",
                    message: ctgTabController.errorDialog,
                    callbackConfirmation: () {
                      ctgTabController.resetErrorDialog();
                      navigator.pop();
                    },
                  ),
                );
              },
            );
          },
          style: DecorationUtils.buttonDialogStyle(),
          child: const Text("Edit"),
        ),
      ],
      callbackClose: () {
        tecTitle.clear();
        navigator.pop();
      },
    );
  }
}
