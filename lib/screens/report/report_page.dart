import 'package:flutter/material.dart';

import 'package:moneymanagement_app/screens/report/pdf_page.dart';

class ReportScreen extends StatelessWidget {
  static ValueNotifier<double?> tincome = ValueNotifier<double?>(0);
  static ValueNotifier<double?> texpense = ValueNotifier<double?>(0);
  static ValueNotifier<String?> incattype = ValueNotifier<String?>('');
  static ValueNotifier<String?> expcattype = ValueNotifier<String?>('');
  static ValueNotifier<String?> creditname = ValueNotifier<String?>(' ');
  static ValueNotifier<double> creditamount = ValueNotifier<double>(0.0);
  static ValueNotifier<double> highestcredit = ValueNotifier<double>(0.0);
  static ValueNotifier<String?> debtname = ValueNotifier<String?>(' ');
  static ValueNotifier<double> debtamount = ValueNotifier<double>(0.0);
  static ValueNotifier<double> highestdebt = ValueNotifier<double>(0.0);

  const ReportScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ValueListenableBuilder(
                valueListenable: tincome,
                builder: (BuildContext context, double? newvalue, Widget? _) {
                  return SizedBox(
                    height: 50,
                    child: Card(
                      elevation: 30,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text("Total Incomings: $newvalue",
                            style: const TextStyle(
                              fontSize: 15,
                            )),
                      ),
                    ),
                  );
                }),
            const SizedBox(height: 10),
            ValueListenableBuilder(
                valueListenable: texpense,
                builder:
                    (BuildContext context, double? newexpvalue, Widget? _) {
                  return SizedBox(
                    height: 50,
                    child: Card(
                        elevation: 30,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "Total Outgoings: $newexpvalue",
                            style: const TextStyle(fontSize: 15),
                          ),
                        )),
                  );
                }),
            const SizedBox(height: 10),
            ValueListenableBuilder(
                valueListenable: incattype,
                builder:
                    (BuildContext context, String? newcategory, Widget? _) {
                  return SizedBox(
                    height: 50,
                    child: Card(
                        elevation: 30,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("High Revenue: $newcategory",
                              style: const TextStyle(fontSize: 15)),
                        )),
                  );
                }),
            const SizedBox(height: 10),
            ValueListenableBuilder(
                valueListenable: expcattype,
                builder:
                    (BuildContext context, String? newexpvalue, Widget? _) {
                  return SizedBox(
                    height: 50,
                    child: Card(
                        elevation: 30,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("Most Expenses: $newexpvalue",
                              style: const TextStyle(fontSize: 15)),
                        )),
                  );
                }),
            const SizedBox(height: 10),
            ValueListenableBuilder(
                valueListenable: creditname,
                builder: (BuildContext context, String? newvalue, Widget? _) {
                  return SizedBox(
                    height: 50,
                    child: Card(
                        elevation: 30,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("Most Credit: $newvalue",
                              style: const TextStyle(fontSize: 15)),
                        )),
                  );
                }),
            const SizedBox(height: 10),
            ValueListenableBuilder(
                valueListenable: highestcredit,
                builder: (BuildContext context, double newvalue, Widget? _) {
                  return SizedBox(
                    height: 50,
                    child: Card(
                        elevation: 30,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("Most Credit amount: $newvalue",
                              style: const TextStyle(fontSize: 15)),
                        )),
                  );
                }),
            const SizedBox(height: 10),
            ValueListenableBuilder(
                valueListenable: creditamount,
                builder: (BuildContext context, double newvalue, Widget? _) {
                  return SizedBox(
                    height: 50,
                    child: Card(
                        elevation: 30,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("Total Credit amount: $newvalue",
                              style: const TextStyle(fontSize: 15)),
                        )),
                  );
                }),
            const SizedBox(height: 10),
            ValueListenableBuilder(
                valueListenable: debtname,
                builder: (BuildContext context, String? newvalue, Widget? _) {
                  return SizedBox(
                    height: 50,
                    child: Card(
                        elevation: 30,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("Most Debt: $newvalue",
                              style: const TextStyle(fontSize: 15)),
                        )),
                  );
                }),
            const SizedBox(height: 10),
            ValueListenableBuilder(
                valueListenable: debtamount,
                builder: (BuildContext context, double newvalue, Widget? _) {
                  return SizedBox(
                    height: 50,
                    child: Card(
                        elevation: 30,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("Most Debt amount: $newvalue",
                              style: const TextStyle(fontSize: 15)),
                        )),
                  );
                }),
            const SizedBox(height: 10),
            ValueListenableBuilder(
                valueListenable: debtamount,
                builder: (BuildContext context, double newvalue, Widget? _) {
                  return SizedBox(
                    height: 50,
                    child: Card(
                        elevation: 30,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("Total Debt amount: $newvalue",
                              style: const TextStyle(fontSize: 15)),
                        )),
                  );
                }),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(PdfScreen.pdfname);
                },
                child: const Text("Genrate pdf")),
          ],
        ),
      )),
    );
  }
}
