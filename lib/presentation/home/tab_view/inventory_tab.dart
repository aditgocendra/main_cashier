import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import '../../../core/components/table_components.dart';
import '../../../core/constant/color_constant.dart';
import '../../../core/constant/values_constant.dart';
import '../../../core/utils/decoration_utils.dart';
import '../../../core/utils/dialog_utils.dart';

class InventoryTab extends StatefulWidget {
  const InventoryTab({super.key});

  @override
  State<InventoryTab> createState() => _InventoryTabState();
}

class _InventoryTabState extends State<InventoryTab> {
  final TextEditingController tecSearch = TextEditingController();
  final TextEditingController tecCode = TextEditingController();
  final TextEditingController tecName = TextEditingController();
  final TextEditingController tecPrice = TextEditingController();
  final TextEditingController tecStock = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                              // if (ctgTabController.isSearch) {
                              //   ctgTabController.tooggleIsSearch();
                              //   ctgTabController.setCategories();
                              //   tecSearch.clear();
                              //   return;
                              // }

                              // if (tecSearch.text.isEmpty) return;

                              // ctgTabController.searchDataCategories(
                              //   tecSearch.text,
                              // );
                            },
                            child: const Icon(
                              UniconsLine.search_alt,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Wrap(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(18),
                            backgroundColor: primaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Generate Report",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
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
                                  child: DialogProductAdd(
                                    // ctgTabController: ctgTabController,
                                    tecCode: tecCode,
                                    tecName: tecName,
                                    tecPrice: tecPrice,
                                    tecStock: tecStock,
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
                            "Create Product",
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
                      size >= 640 ? Axis.vertical : Axis.horizontal,
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
                    // defaultColumnWidth: FixedColumnWidth(1800 / 3),
                    columnWidths: const <int, TableColumnWidth>{
                      0: IntrinsicColumnWidth(),
                      1: IntrinsicColumnWidth(),
                      2: IntrinsicColumnWidth(),
                      3: IntrinsicColumnWidth(),
                      4: IntrinsicColumnWidth(),
                      5: IntrinsicColumnWidth(),
                      6: IntrinsicColumnWidth(),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: <TableRow>[
                      // Header Data Table
                      TableComponent.headerTable(
                        [
                          "Number",
                          "Code",
                          "Name",
                          "Price",
                          "Stock",
                          "Sold",
                          "Action",
                        ],
                      ),
                      // Body Data Table
                      // ...ctgTabController.listCategory.map((val) {
                      //   return TableRow(
                      //     children: [
                      //       TableCell(
                      //         child: Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Center(
                      //             child: Text(
                      //               val.id.toString(),
                      //               style: const TextStyle(fontSize: 14),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //       TableCell(
                      //         child: Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Center(
                      //             child: Text(
                      //               val.title,
                      //               style: const TextStyle(fontSize: 14),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //       TableCell(
                      //         child: Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Center(
                      //             child: Wrap(
                      //               children: [
                      //                 // Edit
                      //                 IconButton(
                      //                   onPressed: () {
                      //                     showDialog(
                      //                       context: context,
                      //                       builder: (context) {
                      //                         return Dialog(
                      //                           shape: RoundedRectangleBorder(
                      //                             borderRadius:
                      //                                 BorderRadius.circular(16),
                      //                           ),
                      //                           child: DialogCategoryEdit(
                      //                             ctg: val,
                      //                             ctgTabController:
                      //                                 ctgTabController,
                      //                             tecTitle: tecTitle,
                      //                           ),
                      //                         );
                      //                       },
                      //                     );
                      //                   },
                      //                   icon: const Icon(UniconsLine.edit),
                      //                 ),
                      //                 // Delete
                      //                 IconButton(
                      //                   onPressed: () {
                      //                     showDialog(
                      //                       context: context,
                      //                       builder: (context) {
                      //                         return DialogUtils
                      //                             .dialogConfirmation(
                      //                           title: "Delete Category",
                      //                           message:
                      //                               "Are you sure delete this category ?",
                      //                           callbackConfirmation: () {
                      //                             ctgTabController
                      //                                 .removeCategory(val);

                      //                             if (ctgTabController
                      //                                 .errorDialog
                      //                                 .isNotEmpty) {}
                      //                             navigator.pop();
                      //                           },
                      //                           callbackCancel: () {
                      //                             navigator.pop();
                      //                           },
                      //                         );
                      //                       },
                      //                     );
                      //                   },
                      //                   icon: const Icon(UniconsLine.trash),
                      //                 )
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   );
                      // }).toList()
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
                              // ctgTabController.updateRowPage(value!);
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
                            // ctgTabController.backPage();
                          },
                          icon: const Icon(Icons.keyboard_arrow_left),
                        ),
                        const Text(
                          "1",
                          // ctgTabController.activeRowPage.toString(),
                          style: TextStyle(
                            fontSize: 12.5,
                          ),
                        ),
                        // Next Page
                        IconButton(
                          onPressed: () {
                            // ctgTabController.nextPage();
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

class DialogProductAdd extends StatelessWidget {
  final TextEditingController tecCode;
  final TextEditingController tecName;
  final TextEditingController tecPrice;
  final TextEditingController tecStock;

  // final CategoryTabController ctgTabController;

  const DialogProductAdd({
    required this.tecCode,
    required this.tecName,
    required this.tecPrice,
    required this.tecStock,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final formKey = GlobalKey<FormState>();

    return DialogUtils.layoutCustomDialog(
      dialogHeaderText: "Create Product",
      childern: [
        Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: tecCode,
                validator: (code) {
                  if (code == null || code.isEmpty) {
                    return fieldRequired;
                  }

                  return null;
                },
                style: const TextStyle(fontSize: 14),
                decoration: DecorationUtils.textFieldDecoration(
                  label: "Product Code",
                  hint: "Example : BN-R-0001",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: tecName,
                validator: (code) {
                  if (code == null || code.isEmpty) {
                    return fieldRequired;
                  }

                  return null;
                },
                style: const TextStyle(fontSize: 14),
                decoration: DecorationUtils.textFieldDecoration(
                  label: "Product Name",
                  hint: "Example : Beng-beng",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: tecPrice,
                validator: (code) {
                  if (code == null || code.isEmpty) {
                    return fieldRequired;
                  }

                  return null;
                },
                style: const TextStyle(fontSize: 14),
                decoration: DecorationUtils.textFieldDecoration(
                  label: "Price",
                  hint: "Example : 20000",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: tecStock,
                validator: (code) {
                  if (code == null || code.isEmpty) {
                    return fieldRequired;
                  }

                  return null;
                },
                style: const TextStyle(fontSize: 14),
                decoration: DecorationUtils.textFieldDecoration(
                  label: "Stock",
                  hint: "Example : 1000",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              DropdownSearch<String>(
                items: const ['Food', 'Drink', 'Something'],
                // selectedItem: widget.controller.conditionSelected,
                // onChanged: (String? value) {
                //   widget.controller.setChangeConditionSelected(value!);
                // },
                popupProps: PopupProps.menu(
                  showSelectedItems: true,
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
                dropdownDecoratorProps: DecorationUtils.dropdownStyleForm(
                  "Select Category",
                ),
              ),
            ],
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

            // ctgTabController.addCategory(tecTitle.text);
            navigator.pop();

            // if (ctgTabController.errorDialog.isNotEmpty) {
            //   showDialog(
            //     context: context,
            //     builder: (context) => DialogUtils.dialogInformation(
            //       title: "Edit Category",
            //       message: ctgTabController.errorDialog,
            //       callbackConfirmation: () => navigator.pop(),
            //     ),
            //   );
            //   ctgTabController.resetErrorDialog();
            // }
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
