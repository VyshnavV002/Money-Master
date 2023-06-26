import 'package:flutter/material.dart';
import 'package:moneymanagement_app/db/stocktracker_db.dart';
import 'package:moneymanagement_app/model/stock_db.dart';
import 'package:moneymanagement_app/screens/drawer/stock_tracking.dart';

class FloatingButton extends StatelessWidget {
  FloatingButton({super.key});
  static final stockNameTracker = TextEditingController();
  static final stockNumTracker = TextEditingController(); //currently-avialable
  static final currstockNumTracker = TextEditingController(); //total-stock

  @override
  Widget build(BuildContext context) {
    Future<void> addValues() async {
      print("This is add values");

      final String namestock = stockNameTracker.text;
      final int? currstock = int.tryParse(stockNumTracker.text);
      final int? totstock = int.tryParse(currstockNumTracker.text);
      

      if (namestock == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Enter name")));
        return;
      }
      if (currstock! > totstock!) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Invalid Entries")));
        return;
      }
      StockTracker st = StockTracker(
        stockname: namestock,
        currstock: currstock,
        totstock: totstock,
      );
      StockTrackerDb.instance.addList(st);
      StockTrackerDb.instance.refreshUi();
    }

    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return SingleChildScrollView(
                child: SizedBox(
                  child: AlertDialog(
                    content: Column(
                      children: [
                        TextFormField(
                          controller: stockNameTracker,
                          decoration: const InputDecoration(
                              label: Text("Stock-name"),
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: stockNumTracker,
                          decoration: const InputDecoration(
                              label: Text("Currently-Avialable"),
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: currstockNumTracker,
                          decoration: const InputDecoration(
                              label: Text("Total-Stock"),
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            addValues();

                            stockNameTracker.clear();
                            stockNumTracker.clear();
                            currstockNumTracker.clear();
                            Navigator.of(context).pop();
                          },
                          child: const Text("Save")),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("cancel")),
                    ],
                  ),
                ),
              );
            });
      },
      child: const Icon(Icons.add),
    );
  }
}
