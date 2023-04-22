import 'dart:io';

import 'package:flutter/services.dart';
import 'package:main_cashier/core/utils/format_utils.dart';
import 'package:main_cashier/domain/entity/detail_transaction_entity.dart';
import 'package:main_cashier/domain/entity/transaction_entity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path/path.dart' as path;

class PdfUtility {
  static Future generateInvoicePdf({
    required TransactionEntity transactionEntity,
    required List<DetailTransactionViewEntity> detailTransaction,
  }) async {
    final doc = pw.Document();

    var dataRegular = await rootBundle.load("assets/fonts/Poppins-Regular.ttf");
    var dataBold = await rootBundle.load("assets/fonts/Poppins-Bold.ttf");
    var dataItalic = await rootBundle.load("assets/fonts/Poppins-Italic.ttf");

    final ttfRegular = pw.Font.ttf(dataRegular.buffer.asByteData());
    final ttfBold = pw.Font.ttf(dataBold.buffer.asByteData());
    final ttfItalic = pw.Font.ttf(dataItalic.buffer.asByteData());

    // Add page to the PDF
    doc.addPage(
      pw.Page(
        pageTheme: _buildTheme(
          PdfPageFormat.roll80,
          ttfRegular,
          ttfBold,
          ttfItalic,
        ),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              _contentHeaderTransaction(
                context,
                transactionEntity.numInvoice,
              ),
              pw.SizedBox(height: 10),
              _contentTableTransaction(context, detailTransaction),
              pw.SizedBox(height: 10),
              _contentFooterTransaction(
                context,
                transactionEntity.totalPay,
              ),
            ],
          );
        },
      ),
    );

    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'example.pdf'));
    file.writeAsBytes(await doc.save());
  }

  static Future generateReportTransaction({
    required List<DateTime> rangeDate,
    required List<TransactionEntity> transactions,
  }) async {
    final doc = pw.Document();

    var dataRegular = await rootBundle.load("assets/fonts/Poppins-Regular.ttf");
    var dataBold = await rootBundle.load("assets/fonts/Poppins-Bold.ttf");
    var dataItalic = await rootBundle.load("assets/fonts/Poppins-Italic.ttf");

    final ttfRegular = pw.Font.ttf(dataRegular.buffer.asByteData());
    final ttfBold = pw.Font.ttf(dataBold.buffer.asByteData());
    final ttfItalic = pw.Font.ttf(dataItalic.buffer.asByteData());

    // Add page to the PDF
    doc.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(
          PdfPageFormat.a4,
          ttfRegular,
          ttfBold,
          ttfItalic,
        ),
        // header: _buildHeader,
        footer: _buildFooter,
        build: (context) => [
          // _contentHeader(context),
          _contentTableReportTransaction(
            context,
            transactions,
          ),
          // pw.SizedBox(height: 20),
          // _contentFooter(context),
          // pw.SizedBox(height: 20),
          // _termsAndConditions(context),
        ],
      ),
    );
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'Transaction-Report.pdf'));
    file.writeAsBytes(await doc.save());
  }

  static pw.PageTheme _buildTheme(
    PdfPageFormat pageFormat,
    pw.Font base,
    pw.Font bold,
    pw.Font italic,
  ) {
    return pw.PageTheme(
      pageFormat: pageFormat,
      theme: pw.ThemeData.withFont(
        base: base,
        bold: bold,
        italic: italic,
      ),
    );
  }

  // static pw.Widget _buildHeader(pw.Context context) {
  //   return pw.Column(
  //     children: [
  //       pw.Row(
  //         crossAxisAlignment: pw.CrossAxisAlignment.start,
  //         children: [
  //           pw.Expanded(
  //             child: pw.Column(
  //               children: [
  //                 pw.Container(
  //                   height: 50,
  //                   padding: const pw.EdgeInsets.only(left: 20),
  //                   alignment: pw.Alignment.centerLeft,
  //                   child: pw.Text(
  //                     'INVOICE',
  //                     style: pw.TextStyle(
  //                       color: PdfColors.amber,
  //                       fontWeight: pw.FontWeight.bold,
  //                       fontSize: 20,
  //                     ),
  //                   ),
  //                 ),
  //                 pw.Container(
  //                   decoration: pw.BoxDecoration(
  //                     borderRadius:
  //                         const pw.BorderRadius.all(pw.Radius.circular(2)),
  //                     color: PdfColors.amber,
  //                   ),
  //                   padding: const pw.EdgeInsets.only(
  //                     left: 20,
  //                     top: 5,
  //                     bottom: 5,
  //                     right: 10,
  //                   ),
  //                   alignment: pw.Alignment.centerLeft,
  //                   height: 30,
  //                   child: pw.DefaultTextStyle(
  //                     style: pw.TextStyle(
  //                       color: PdfColors.amber,
  //                       fontSize: 12,
  //                     ),
  //                     child: pw.GridView(
  //                       crossAxisCount: 2,
  //                       children: [
  //                         pw.Text('Invoice #'),
  //                         pw.Text("invoiceNumber"),
  //                         pw.Text('Date:'),
  //                         pw.Text("asdasd"),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //       if (context.pageNumber > 1) pw.SizedBox(height: 20)
  //     ],
  //   );
  // }

  static pw.Widget _buildFooter(pw.Context context) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Container(
          height: 20,
          width: 100,
          child: pw.BarcodeWidget(
            barcode: pw.Barcode.pdf417(),
            data: 'Invoice# 120203',
            drawText: false,
          ),
        ),
        pw.Text(
          'Page ${context.pageNumber}/${context.pagesCount}',
          style: const pw.TextStyle(
            fontSize: 12,
            color: PdfColors.white,
          ),
        ),
      ],
    );
  }

  static pw.Widget _contentHeaderTransaction(
      pw.Context context, String numInvoice) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          "No. $numInvoice",
          style: pw.TextStyle(
            fontSize: 5,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Text(
          "14 Apr 2023",
          style: pw.TextStyle(
            fontSize: 5,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ],
    );
  }

  static pw.Widget _contentTableTransaction(
      pw.Context context, List<DetailTransactionViewEntity> listTransaction) {
    const tableHeaders = [
      'Product Name',
      'Price',
      'Quantity',
      'Total',
    ];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            width: 1,
            color: PdfColors.black,
          ),
        ),
      ),
      headerHeight: 12.5,
      cellHeight: 20,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.center,
        2: pw.Alignment.center,
        3: pw.Alignment.centerRight,
      },
      headerStyle: pw.TextStyle(
        color: PdfColors.black,
        fontSize: 5,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        color: PdfColors.black,
        fontSize: 5,
      ),
      rowDecoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: PdfColors.black,
            width: .5,
          ),
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        listTransaction.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => listTransaction[row].getIndex(col),
        ),
      ),
    );
  }

  static pw.Widget _contentTableReportTransaction(
      pw.Context context, List<TransactionEntity> transactions) {
    const tableHeaders = [
      'No Invoice',
      'Total Payment',
      'Date Transaction',
    ];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            width: 2,
            color: PdfColors.black,
          ),
        ),
      ),
      headerHeight: 16,
      cellHeight: 28,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.center,
        2: pw.Alignment.centerRight,
      },
      headerStyle: pw.TextStyle(
        color: PdfColors.black,
        fontSize: 12,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        color: PdfColors.black,
        fontSize: 12,
      ),
      rowDecoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: PdfColors.black,
            width: .5,
          ),
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        transactions.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => transactions[row].getIndex(col),
        ),
      ),
    );
  }

  static pw.Widget _contentFooterTransaction(pw.Context context, int totalPay) {
    return pw.Text(
      "Total Payment : ${FormatUtility.currencyRp(totalPay)}",
      style: pw.TextStyle(
        fontSize: 6,
        fontWeight: pw.FontWeight.bold,
      ),
      textAlign: pw.TextAlign.right,
    );
  }
}
