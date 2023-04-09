import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unicons/unicons.dart';

import '../../../core/components/table_components.dart';
import '../../../core/constant/color_constant.dart';

class TransactionTab extends StatelessWidget {
  const TransactionTab({super.key});

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    // final ctgTabController = context.watch<CategoryTabController>();
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
                        // controller: tecSearch,
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
                        const SizedBox(
                          width: 12,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.go('/transaction');
                            // showDialog(
                            //   context: context,
                            //   builder: (context) {
                            //     return Dialog(
                            //       shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(16),
                            //       ),
                            //       child: DialogCategoryAdd(
                            //         ctgTabController: ctgTabController,
                            //         tecTitle: tecTitle,
                            //       ),
                            //     );
                            //   },
                            // );
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
                            "Create Transaction",
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
                    // defaultColumnWidth: FixedColumnWidth(1800 / 3),
                    columnWidths: const <int, TableColumnWidth>{
                      0: IntrinsicColumnWidth(),
                      1: IntrinsicColumnWidth(),
                      2: IntrinsicColumnWidth(),
                      3: IntrinsicColumnWidth(),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: <TableRow>[
                      // Header Data Table
                      TableComponent.headerTable(
                        [
                          "Code Transaction",
                          "Date Transaction",
                          "Total Payment",
                          "Action"
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
                        Text(
                          "",
                          // ctgTabController.activeRowPage.toString(),
                          style: const TextStyle(
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
