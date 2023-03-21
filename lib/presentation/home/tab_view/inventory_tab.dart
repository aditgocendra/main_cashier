import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import '../../../core/constant/color_constant.dart';

class InventoryTab extends StatelessWidget {
  const InventoryTab({super.key});

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
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        backgroundColor: primaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
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
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        backgroundColor: primaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text(
                        "Product Add",
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
                Table(
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
                    3: FlexColumnWidth(),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: const <TableRow>[
                    // Header Data Table
                    TableRow(
                      // decoration: BoxDecoration(color: backgroundColor),
                      children: [
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(
                              child: Text(
                                "Kode Produk",
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
                                "Nama Produk",
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
                                "Category",
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
                                "Harga Produk",
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
                                "Aksi",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(
                              child: Text(
                                "Kode Produk",
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
                                "Nama Produk",
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
                                "Category",
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
                                "Harga Produk",
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
                                "Aksi",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
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
