import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:moneymanagement_app/db/stocktracker_db.dart';
import 'package:moneymanagement_app/model/stock_db.dart';

import 'package:moneymanagement_app/reusable_widgets/floating_button.dart';
import 'package:moneymanagement_app/reusable_widgets/searchbar.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StockScreen extends StatefulWidget {
  StockScreen({super.key});
  static const stockscreen = "stock-screen";
  static final ValueNotifier valuelistner = ValueNotifier(0);

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  @override
  void initState() {
    StockTrackerDb.instance.refreshUi();
    super.initState();
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
                        if (currstock! > totstock!) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Invalid Enteries")));
                          return;
                        }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingButton(),
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("Stock Tracking"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context, delegate: CustomSearchDelegate(context));
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: ValueListenableBuilder(
                      valueListenable: StockTrackerDb.instance.stockList,
                      builder: (BuildContext context,
                          List<StockTracker> newList, Widget? _) {
                        return ListView.separated(
                            itemBuilder: (BuildContext context, int index) {
                              final values = newList[index];
                              return Slidable(
                                endActionPane: ActionPane(
                                    motion: const StretchMotion(),
                                    children: [
                                      SlidableAction(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          onPressed: (context) {
                                            print(
                                                "this is onPressed:${values.id}");
                                            updatevalues(
                                                values.id,
                                                values.stockname,
                                                values.totstock);
                                          },
                                          backgroundColor: Colors.grey,
                                          icon: Icons.settings),
                                      SlidableAction(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          backgroundColor: Colors.red,
                                          onPressed: (context) {
                                            StockTrackerDb.instance
                                                .deleteList(values.id!);
                                          },
                                          icon: Icons.delete),
                                    ]),
                                child: Card(
                                    elevation: 30,
                                    child: ListTile(
                                      leading: SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: CircularPercentIndicator(
                                            progressColor: Colors.green,
                                            radius: 20,
                                            percent: (values.currstock) /
                                                (values.totstock),
                                          )),
                                      title: Row(
                                        children: [
                                          const Text("Stock Name: "),
                                          Text(values.stockname),
                                        ],
                                      ),
                                      subtitle: Row(
                                        children: [
                                          const Text("Currently Avialable: "),
                                          Text(values.currstock.toString()),
                                        ],
                                      ),
                                    )),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                            itemCount: newList.length);
                      })),
            ),
          ),
        ],
      )),
    );
  }
}
