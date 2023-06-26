import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:moneymanagement_app/db/stocktracker_db.dart';
import 'package:moneymanagement_app/model/stock_db.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

class CustomSearchDelegate extends SearchDelegate {
  BuildContext context;
  CustomSearchDelegate(this.context);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = " ";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<StockTracker> matchQuery = [];
    for (var item in StockTrackerDb.instance.stockList.value) {
      if (item.stockname.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 30,
            child: Slidable(
              endActionPane:
                  ActionPane(motion: const StretchMotion(), children: [
                SlidableAction(
                    borderRadius: BorderRadius.circular(10),
                    onPressed: (context) {
                      print("this is onPressed:${result.id}");
                      if (result.id != null) {
                        updatevalues(
                            result.id, result.stockname, result.totstock);
                      }
                    },
                    backgroundColor: Colors.grey,
                    icon: Icons.settings),
                SlidableAction(
                    borderRadius: BorderRadius.circular(10),
                    backgroundColor: Colors.red,
                    onPressed: (context) {
                      StockTrackerDb.instance.deleteList(result.id!);
                    },
                    icon: Icons.delete),
              ]),
              child: ListTile(
                leading: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularPercentIndicator(
                      progressColor: Colors.green,
                      radius: 20,
                      percent: (result.currstock) / (result.totstock),
                    )),
                title: Text("Stock Name:${result.stockname}"),
                subtitle: Text("Currently Avialable:${result.currstock}"),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<StockTracker> matchQuery = [];
    for (var item in StockTrackerDb.instance.stockList.value) {
      if (item.toString().toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return Container(color: Colors.grey);
      },
    );
  }

  Future<void> updatevalues(String? id, String name, int totalstock) {
    print("id=${id}");
    TextEditingController stockNameTracker = TextEditingController();
    TextEditingController stockNumTracker = TextEditingController();
    TextEditingController currstockNumTracker = TextEditingController();
    currstockNumTracker.text = totalstock.toString();
    stockNameTracker.text = name;
    return showDialog(
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
                        final stockname = stockNameTracker.text;
                        final currstock = int.tryParse(stockNumTracker.text);
                        final totstock = int.tryParse(currstockNumTracker.text);
                        StockTracker st = StockTracker(
                            stockname: stockname,
                            currstock: currstock!,
                            totstock: totstock!);
                        StockTrackerDb.instance.updateList(id, st);
                        Navigator.pop(context);
                      },
                      child: const Text("Save")),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"))
                ],
              ),
            ),
          );
        });
  }
}
