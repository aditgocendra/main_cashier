import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/format_utils.dart';

import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../core/components/table_components.dart';
import '../../core/constant/color_constant.dart';
import 'transaction_controller.dart';

class TransactionView extends StatelessWidget {
  TransactionView({super.key});

  final TextEditingController tecProductAdd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final controller = context.watch<TransactionController>();
    final size = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ListView(
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
                      InkWell(
                        onTap: () => context.go("/"),
                        child: const Text(
                          "Home",
                          style: TextStyle(
                            color: primaryColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          controller: tecProductAdd,
                          style: const TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            fillColor: Colors.white60,
                            hintText: "Code Product",
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
                                final String code = tecProductAdd.text;

                                if (code.isEmpty) return;

                                controller.selectProductData(
                                  tecProductAdd.text,
                                );

                                tecProductAdd.clear();
                              },
                              child: const Icon(
                                UniconsLine.plus_circle,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
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
                        4: IntrinsicColumnWidth(),
                        5: IntrinsicColumnWidth(),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: <TableRow>[
                        // Header Data Table
                        TableComponent.headerTable(
                          [
                            "Code Product",
                            "Name",
                            "Price",
                            "Qty",
                            "Total",
                            "Action"
                          ],
                        ),
                        // Body Data Table
                        ...controller.listProduct
                            .asMap()
                            .map(
                              (index, val) => MapEntry(
                                index,
                                TableRow(
                                  children: [
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            val.code,
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            val.name,
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            FormatUtility.currencyRp(
                                              val.sellPrice,
                                            ),
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: TextField(
                                            controller:
                                                controller.listTecQty[index],
                                            onChanged: (value) {
                                              controller.changeQtyPrice(index);
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                            textAlign: TextAlign.center,
                                            keyboardType: TextInputType.number,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            FormatUtility.currencyRp(
                                              controller.listTotalQty[index],
                                            ),
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: IconButton(
                                            onPressed: () {
                                              controller.removeProduct(index);
                                            },
                                            icon: const Icon(UniconsLine.trash),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Total Payment"),
                          Text(
                            FormatUtility.currencyRp(controller.totalPay),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          )
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.addTransaction();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(18),
                          backgroundColor: primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text("Transaction"),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
