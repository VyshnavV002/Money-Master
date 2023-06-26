import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moneymanagement_app/screens/drawer/pie_screen.dart';

class DashScreen {
  double? tincome;
  double? texpense;

  DashScreen._internal();
  static DashScreen instance = DashScreen._internal();
  factory DashScreen() {
    return instance;
  }
}

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});
  static ValueNotifier<double?> incomeValue = ValueNotifier<double?>(0.0);
  static ValueNotifier<double?> expenseValue = ValueNotifier<double?>(0.0);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ValueListenableBuilder(
                    valueListenable: DashBoard.incomeValue,
                    builder:
                        (BuildContext context, double? newvalue, Widget? _) {
                      double? invalue = newvalue;
                      return SizedBox(
                          width: 50,
                          height: 100,
                          child: Card(
                              elevation: 30,
                              color: const Color.fromARGB(255, 94, 235, 98),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(top: 8.0, left: 3.0),
                                    child: Text("Income:",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 12),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text("Rs ${invalue.toString()}",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 28,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                ],
                              )));
                    }),
              ),
              Expanded(
                child: ValueListenableBuilder(
                    valueListenable: DashBoard.expenseValue,
                    builder:
                        (BuildContext context, double? newvalue, Widget? _) {
                      print(newvalue);
                      double? epvalue = newvalue;
                      return SizedBox(
                          height: 100,
                          child: Card(
                              elevation: 30,
                              color:const Color.fromARGB(255, 243, 66, 54),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding:  EdgeInsets.only(
                                        top: 8.0, left: 3.0),
                                    child: Text("Expenses:",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 12),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text("Rs ${epvalue.toString()}",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 28,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                ],
                              )));
                    }),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(PieScreen.piescreen);
                },
                child: const Text("View Chart")),
          ])
        ],
      ),
    );
  }
}
