import 'dart:ffi';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:moneymanagement_app/dashboard/dash_screen.dart';

import 'package:moneymanagement_app/model/category.dart';
import 'package:moneymanagement_app/model/transaction_add.dart';
import 'package:moneymanagement_app/reusable_widgets/subincome_dash.dart';
import 'package:moneymanagement_app/screens/category/sub_category/income_sub.dart';
import 'package:moneymanagement_app/screens/report/report_page.dart';

const TRANSACTION_DB_NAME = "transaction_db";

abstract class TransactionModal {
  Future<void> addList(AddTransaction obj);
  Future<List<AddTransaction>> getList();
  Future<void> deleteList(String id);
}

class TransactionDb implements TransactionModal {
  TransactionDb._internal();
  static TransactionDb instance = TransactionDb._internal();
  factory TransactionDb() {
    return instance;
  }

  double sum = 0;
  ValueNotifier<List<AddTransaction>> transactionList = ValueNotifier([]);
  Future<void> refreshUI() async {
    print("I am inside refresh ui ");
    final _list = await getList();
    _list.sort((first, second) => second.date.compareTo(first.date));
    transactionList.value.clear();
    transactionList.value.addAll(_list);

    TransactionDb.instance.calIncome();
    TransactionDb.instance.credebt();

    transactionList.notifyListeners();
  }

  @override
  Future<void> addList(AddTransaction obj) async {
    final _db = await Hive.openBox<AddTransaction>(TRANSACTION_DB_NAME);
    await _db.put(obj.id, obj);
  }

  @override
  Future<List<AddTransaction>> getList() async {
    final _db = await Hive.openBox<AddTransaction>(TRANSACTION_DB_NAME);

    return _db.values.toList();
  }

  @override
  Future<void> deleteList(String Transactionid) async {
    final _db = await Hive.openBox<AddTransaction>(TRANSACTION_DB_NAME);
    await _db.delete(Transactionid);
    print("I am in delete");
    refreshUI();
  }

  Future<void> calIncome() async {
    final _db = await Hive.openBox<AddTransaction>(TRANSACTION_DB_NAME);
    double totalincome = 0;
    double totalexpenses = 0;
    double maxincome = 0;
    double maxexp = 0;
    String intype = ' ';
    String exptype = ' ';
    for (var key in _db.keys) {
      var amvalue = _db.get(key);
      if (amvalue != null) {
        if (amvalue.ctype == CategoryType.income) {
          if (amvalue.amount > maxincome) {
            maxincome = amvalue.amount;
            intype = amvalue.modal.name;
          }
          totalincome += amvalue.amount;
        } else {
          if (amvalue.amount > maxexp) {
            maxexp = amvalue.amount;
            exptype = amvalue.modal.name;
          }
          totalexpenses += amvalue.amount;
        }
      }
    }
    print(intype.toString());
    DashScreen.instance.texpense = totalexpenses;
    DashScreen.instance.tincome = totalincome;
    DashBoard.incomeValue.value = DashScreen.instance.tincome;
    print("valueNotifier=${DashBoard.incomeValue.value}");
    DashBoard.expenseValue.value = totalexpenses.toDouble();
    ReportScreen.tincome.value = DashBoard.incomeValue.value;
    ReportScreen.texpense.value = DashBoard.expenseValue.value;
    ReportScreen.incattype.value = intype;
    ReportScreen.expcattype.value = exptype;
    ReportScreen.incattype.notifyListeners();
    ReportScreen.expcattype.notifyListeners();
  }

  Future<void> credebt() async {
    final _db = await Hive.openBox<AddTransaction>(TRANSACTION_DB_NAME);
    String crname = " ";
    String dbname = " ";
    double dvalue = 0.0;
    double cvalue = 0.0;
    double dbvalue = 0;
    double crvalue = 0;
    double totalcredit = 0;
    double totaldebt = 0;
    for (var key in _db.keys) {
      var amvalue = _db.get(key);
      if (amvalue != null) {
        if (amvalue.modal.name == "credit") {
          if (amvalue.amount > cvalue) {
            cvalue = amvalue.amount;
            crname = amvalue.purpose;
            crvalue = amvalue.amount;
          }

          totalcredit += amvalue.amount;
        }
        if (amvalue.ctype == CategoryType.expenses) {
          if (amvalue.modal.name == "debt") {
            if (amvalue.amount > dvalue) {
              dvalue = amvalue.amount;
              dbname = amvalue.purpose;
              dbvalue = amvalue.amount;
            }

            totaldebt += amvalue.amount;
          }
        }
      }
    }
    ReportScreen.creditname.value = crname;
    ReportScreen.highestcredit.value = crvalue;
    ReportScreen.creditamount.value = totalcredit;
    ReportScreen.highestcredit.notifyListeners();
    ReportScreen.creditname.notifyListeners();
    ReportScreen.creditamount.notifyListeners();
    ReportScreen.debtname.value = dbname;
    ReportScreen.debtamount.value = dbvalue;
    ReportScreen.highestdebt.value = totaldebt;
    ReportScreen.debtamount.notifyListeners();
    ReportScreen.debtname.notifyListeners();
    ReportScreen.highestdebt.notifyListeners();
  }

  Future<void> getsum(String id) async {
    final _db = await Hive.openBox<AddTransaction>(TRANSACTION_DB_NAME);
    sum = 0;
    print("I am inside get sum");
    for (var key in _db.keys) {
      var amvalue = _db.get(key);
      if (amvalue!.modal.id == id) {
        sum += amvalue.amount;
      }
    }
    print(sum);
    SubIncomeDash.valueid.value = sum;
    SubIncomeDash.valueid.notifyListeners();
  }
}
