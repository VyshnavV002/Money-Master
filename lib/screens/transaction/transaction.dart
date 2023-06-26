import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:intl/intl.dart';
import 'package:moneymanagement_app/dashboard/dash_screen.dart';
import 'package:moneymanagement_app/db/category_db.dart';
import 'package:moneymanagement_app/db/transaction_db.dart';
import 'package:moneymanagement_app/model/category.dart';
import 'package:moneymanagement_app/model/transaction_add.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({super.key});
  String parseDate(DateTime value) {
    final _date = DateFormat.MMMd().format(value);
    final splitdate = _date.split(' ');
    return '${splitdate.last}\n${splitdate.first}';
  }

  @override
  Widget build(BuildContext context) {
    CategoryDb.instance.refreshUI();
    TransactionDb.instance.refreshUI();
    return Column(
      children: [
        const DashBoard(),
        ValueListenableBuilder(
            valueListenable: TransactionDb.instance.transactionList,
            builder:
                (BuildContext ctx, List<AddTransaction> newList, Widget? _) {
              return Expanded(
                child: SizedBox(
                  height: 400,
                  child: ListView.separated(
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (ctx, index) {
                        final values = newList[index];
                        return Card(
                          elevation: 30,
                          child: Slidable(
                            endActionPane: ActionPane(
                                motion: const StretchMotion(),
                                children: [
                                  SlidableAction(
                                      backgroundColor: Colors.red,
                                      onPressed: (context) {
                                        TransactionDb.instance
                                            .deleteList(values.id!);
                                      },
                                      icon: Icons.delete)
                                ]),
                            child: ListTile(
                                leading: CircleAvatar(
                                  child: Text(parseDate(values.date)),
                                  radius: 50,
                                  backgroundColor:
                                      values.ctype == CategoryType.income
                                          ?const  Color.fromARGB(255, 16, 214, 22)
                                          : Colors.red[900],
                                ),
                                title: Text("Rs ${values.amount}"),
                                subtitle: Text(values.purpose)),
                          ),
                        );
                      },
                      separatorBuilder: (ctx, index) {
                        return const SizedBox(height: 10);
                      },
                      itemCount: newList.length),
                ),
              );
            }),
      ],
    );
  }
}
