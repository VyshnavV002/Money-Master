import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moneymanagement_app/model/stock_db.dart';

class StockTrackerDb {
  StockTrackerDb._internal();
  static StockTrackerDb instance = StockTrackerDb._internal();
  factory StockTrackerDb() {
    return instance;
  }

  final ValueNotifier<List<StockTracker>> stockList = ValueNotifier([]);
  Future<void> refreshUi() async {
    print("this is refresh UI");
    final _list = await getList();

    stockList.value.clear();
    stockList.value.addAll(_list);
    stockList.notifyListeners();
  }

  Future<void> addList(StockTracker obj) async {
    final myBox = await Hive.openBox<StockTracker>("mybox");
    await myBox.put(obj.id, obj);
    print("this is add List");
  }

  Future<List<StockTracker>> getList() async {
    final myBox = await Hive.openBox<StockTracker>("mybox");
    return myBox.values.toList();
  }

  Future<void> deleteList(String? id) async {
    final myBox = await Hive.openBox<StockTracker>("mybox");
    await myBox.delete(id);
    refreshUi();
  }

  Future<void> updateList(String? id, StockTracker obj) async {
    print(obj.id);
    final myBox = await Hive.openBox<StockTracker>("mybox");
    obj.id = id;
    await myBox.put(id, obj);

    refreshUi();
  }
}
