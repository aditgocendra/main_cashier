import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../core/utils/pdf_utils.dart';
import '../../../core/utils/format_utils.dart';
import '../../../domain/entity/transaction_entity.dart';
import '../../../core/components/table_components.dart';
import '../../../core/constant/color_constant.dart';
import '../../../core/utils/decoration_utils.dart';
import '../../../core/utils/dialog_utils.dart';
import '../tab_controller/transaction_tab_controller.dart';

class TransactionTab extends StatefulWidget {
  const TransactionTab({super.key});

  @override
  State<TransactionTab> createState() => _TransactionTabState();
}

class _TransactionTabState extends State<TransactionTab> {
  final TextEditingController tecSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    final controller = context.read<TransactionTabController>();
    controller.setTransaction();
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final controller = context.watch<TransactionTabController>();
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
                          hintText: "Search (No)",
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
                                controller.setTransaction();
                                tecSearch.clear();
                                return;
                              }

                              if (tecSearch.text.isEmpty) return;

                              controller.searchDataTransaction(
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
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const Dialog(
                                  child: DialogGenerateReport(),
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
                            "Generate Report",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.go('/transaction');
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
                          "No",
                          "Date Transaction",
                          "Total Payment",
                          "Action",
                        ],
                      ),
                      // Body Data Table
                      ...controller.listTransaction.map((val) {
                        return TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    val.numInvoice,
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
                                    FormatUtility.dMMMyFormat(
                                      val.dateTransaction,
                                    ),
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
                                    FormatUtility.currencyRp(val.totalPay),
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
                                      // Detail
                                      IconButton(
                                        onPressed: () {
                                          controller.setDetailTransaction(
                                            idTransaction: val.id,
                                            callbackFail: () => showDialog(
                                              context: context,
                                              builder: (context) {
                                                return DialogUtils
                                                    .dialogInformation(
                                                  title: "Detail Transaction",
                                                  message:
                                                      "Fail get detail transaction",
                                                  callbackConfirmation: () =>
                                                      navigator.pop(),
                                                );
                                              },
                                            ),
                                            callbackSuccess: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                    child:
                                                        DialogDetailTransaction(
                                                      transactionEntity: val,
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(UniconsLine.eye),
                                      ),
                                      // Delete
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return DialogUtils
                                                  .dialogConfirmation(
                                                title: "Delete Transaction",
                                                message:
                                                    "Are you sure delete this transaction ?",
                                                callbackConfirmation: () {
                                                  controller.removeTransaction(
                                                    idTransaction: val.id,
                                                    callbackFail: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return DialogUtils
                                                              .dialogInformation(
                                                            title:
                                                                "Delete Fail",
                                                            message:
                                                                "Fail remove this transaction",
                                                            callbackConfirmation:
                                                                () {
                                                              navigator.pop();
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                    callbackSuccess: () =>
                                                        navigator.pop(),
                                                  );
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
                          controller.activeRowPage.toString(),
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

class DialogDetailTransaction extends StatelessWidget {
  final TransactionEntity transactionEntity;

  const DialogDetailTransaction({
    required this.transactionEntity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final controller = context.watch<TransactionTabController>();
    final size = MediaQuery.of(context).size.width;

    return DialogUtils.layoutCustomDialog(
      dialogHeaderText: "Detail Transaction",
      childern: [
        Text(
          "No. ${transactionEntity.numInvoice}",
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SingleChildScrollView(
          scrollDirection: size >= 450 ? Axis.vertical : Axis.horizontal,
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
              3: IntrinsicColumnWidth(),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              // Header Data Table
              TableComponent.headerTable(
                [
                  "Name",
                  "Price",
                  "Qty",
                  "Total",
                ],
              ),
              // Body Data Table
              ...controller.listProductTransaction.map((val) {
                return TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            val.name,
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
                            FormatUtility.currencyRp(val.sellPrice),
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
                            val.qty.toString(),
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
                            FormatUtility.currencyRp(val.total),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
              TableRow(
                children: [
                  const TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "Total Payment",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                  ),
                  const TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          FormatUtility.currencyRp(transactionEntity.totalPay),
                          style: const TextStyle(
                            fontSize: 16,
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        ElevatedButton(
          onPressed: () {
            PdfUtility.generateInvoicePdf(
              transactionEntity: transactionEntity,
              productTansactions: controller.listProductTransaction,
            );
            navigator.pop();
          },
          style: DecorationUtils.buttonDialogStyle(),
          child: const Text("Generate Invoice"),
        ),
      ],
      callbackClose: () {
        navigator.pop();
      },
    );
  }
}

class DialogGenerateReport extends StatelessWidget {
  const DialogGenerateReport({super.key});

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final controller = context.watch<TransactionTabController>();

    final config = CalendarDatePicker2Config(
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: primaryColor,
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );

    return DialogUtils.layoutCustomDialog(
      dialogHeaderText: "Generate Report Transaction",
      childern: [
        CalendarDatePicker2(
          config: config,
          value: controller.rangeDatePicker,
          onValueChanged: (value) {
            if (value.length < 2) return;
            controller.setSelectionRangeDate(value);
          },
        ),
        const SizedBox(
          height: 16,
        ),
        ElevatedButton(
          onPressed: () async {
            final result = await controller.getReportTransaction();
            final omzet = await controller.getOmzetTransactionWithRange();
            final profit = await controller.getProfitTransactionWithRange();

            await PdfUtility.generateReportTransaction(
              rangeDate: controller.rangeDatePicker,
              reportTransaction: result,
              omzet: omzet!,
              profit: profit,
            );

            navigator.pop();
          },
          style: DecorationUtils.buttonDialogStyle(),
          child: const Text("Generate Invoice"),
        ),
      ],
      callbackClose: () => navigator.pop(),
    );
  }
}
