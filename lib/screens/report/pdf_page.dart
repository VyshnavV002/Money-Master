import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:moneymanagement_app/screens/report/report_page.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfScreen extends StatelessWidget {
  static const pdfname = "pdf-page";
  final String title = "Report";

  const PdfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: PdfPreview(
          build: (format) => _generatePdf(format, title),
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

    final font = await PdfGoogleFonts.nunitoExtraLight();
    final contfont = await PdfGoogleFonts.latoBold();
    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.ListView(
            children: [
              pw.SizedBox(
                width: double.infinity,
                child: pw.FittedBox(
                  child: pw.Text(title,
                      style: pw.TextStyle(font: font, fontSize: 15)),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text("1.Total Incomings: ${ReportScreen.tincome.value}",
                  style: pw.TextStyle(font: contfont, fontSize: 25)),
              pw.SizedBox(height: 10),
              pw.Text("2.Total Outgoings: ${ReportScreen.texpense.value}",
                  style: pw.TextStyle(font: contfont, fontSize: 25)),
              pw.SizedBox(height: 10),
              pw.Text("3.Highest Borrower: ${ReportScreen.creditname.value}",
                  style: pw.TextStyle(font: contfont, fontSize: 25)),
              pw.SizedBox(height: 10),
              pw.Text(
                  "4.Highest Borrowed Amount: ${ReportScreen.highestcredit.value}",
                  style: pw.TextStyle(font: contfont, fontSize: 25)),
              pw.SizedBox(height: 10),
              pw.Text(
                  "5.Total Borrowed Amount: ${ReportScreen.creditamount.value}",
                  style: pw.TextStyle(font: contfont, fontSize: 25)),
              pw.SizedBox(height: 10),
              pw.Text("6.Highest Lender: ${ReportScreen.debtname.value}",
                  style: pw.TextStyle(font: contfont, fontSize: 25)),
              pw.SizedBox(height: 10),
              pw.Text(
                  "7.Highest Lended Amount: ${ReportScreen.highestdebt.value}",
                  style: pw.TextStyle(font: contfont, fontSize: 25)),
              pw.SizedBox(height: 10),
              pw.Text("8.Total Debt: ${ReportScreen.debtamount.value}",
                  style: pw.TextStyle(font: contfont, fontSize: 25)),
              pw.SizedBox(height: 10),
              pw.Text(
                  "9.Most Income Genrated Category: ${ReportScreen.incattype.value}",
                  style: pw.TextStyle(font: contfont, fontSize: 25)),
              pw.SizedBox(height: 10),
              pw.Text(
                  "10.Most Lost Genrated Category: ${ReportScreen.expcattype.value}",
                  style: pw.TextStyle(font: contfont, fontSize: 25)),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
