import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:main_cashier/auth_state.dart';
import 'package:main_cashier/color_app.dart';
import 'package:main_cashier/core/utils/dialog_utils.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../core/utils/format_utils.dart';
import '../../core/components/table_components.dart';
import 'transaction_controller.dart';

class TransactionView extends StatelessWidget {
  TransactionView({super.key});

  final TextEditingController tecProductAdd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final controller = context.watch<TransactionController>();
    final colorApp = context.watch<ColorApp>();
    final authState = context.watch<AuthState>();
    final size = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Container(
            decoration: BoxDecoration(
              color: colorApp.canvas,
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
                      IconButton(
                        icon: Icon(
                          Icons.home_outlined,
                          color: colorApp.primary,
                          size: 32,
                        ),
                        onPressed: () {
                          if (authState.userEntity!.roleId != 2) {
                            controller.reset();
                            navigator.pop();
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return DialogUtils.dialogConfirmation(
                                  title: "Logout",
                                  message: "Are you sure ?",
                                  primary: colorApp.primary,
                                  callbackConfirmation: () async {
                                    await authState.logout().then(
                                          (_) => navigator.pop(),
                                        );
                                  },
                                  callbackCancel: () => navigator.pop(),
                                );
                              },
                            );
                          }
                        },
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
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorApp.border,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            errorText: controller.errSelectProduct,
                            suffixIcon: InkWell(
                              onTap: () {
                                controller.clearError();
                                final String code = tecProductAdd.text;

                                if (code.isEmpty) return;

                                controller.selectProductData(
                                  tecProductAdd.text,
                                );

                                tecProductAdd.clear();
                              },
                              child: Icon(
                                UniconsLine.plus_circle,
                                color: controller.errSelectProduct != null
                                    ? Colors.red
                                    : colorApp.primary,
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
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
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
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: colorApp.primary,
                            ),
                          )
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.addTransaction(
                            () {
                              controller.reset();
                              navigator.pop();
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(18),
                          backgroundColor: colorApp.primary,
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
