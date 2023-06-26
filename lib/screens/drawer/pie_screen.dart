import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moneymanagement_app/dashboard/dash_screen.dart';

class ExpValue {
  static final expvalue = DashBoard.expenseValue;
}

class PieScreen extends StatelessWidget {
  PieScreen({super.key});
  static const piescreen = "pie-screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PieChart"),
      ),
      body: SafeArea(
          child: ListView(padding: const EdgeInsets.all(10.0), children: [
        ValueListenableBuilder<double?>(
            valueListenable: DashBoard.incomeValue,
            builder: (BuildContext context, double? newvalue, Widget? _) {
              return Center(
                child: SizedBox(
                  height: 350,
                  width: 100,
                  child: PieChart(PieChartData(sections: [
                    PieChartSectionData(
                      value: newvalue,
                      color: const Color.fromARGB(255, 15, 226, 22),
                      showTitle: true,
                      title: "Income",
                      radius: 150,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    PieChartSectionData(
                        value: ExpValue.expvalue.value,
                        color: const Color.fromARGB(255, 224, 50, 37),
                        showTitle: true,
                        title: "Expense",
                        radius: 150,
                        titleStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ))
                  ], centerSpaceRadius: 0)),
                ),
              );
            }),
      ])),
    );
  }
}
