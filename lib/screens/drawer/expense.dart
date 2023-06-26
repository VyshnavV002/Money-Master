import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:moneymanagement_app/db/category_db.dart';
import 'package:moneymanagement_app/db/transaction_db.dart';
import 'package:moneymanagement_app/model/category.dart';
import 'package:moneymanagement_app/model/transaction_add.dart';
import 'package:moneymanagement_app/screens/transaction/transaction.dart';

class ExpenseTrackerScreen extends StatelessWidget {
  const ExpenseTrackerScreen({super.key});
  static const expensescreen = "expense-tracker";
  @override
  Widget build(BuildContext context) {
    CategoryDb.instance.refreshUI();
    TransactionDb.instance.refreshUI();
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(title: const Text("Expense Tracker")),
        body: SafeArea(
            child: Column(
          children: [
            ValueListenableBuilder(
                valueListenable: TransactionDb.instance.transactionList,
                builder: (BuildContext context, List<AddTransaction> newlist,
                    Widget? _) {
                  return Expanded(
                    child: SizedBox(
                      height: 400,
                      child: ListView.separated(
                          padding: const EdgeInsets.all(8.0),
                          itemBuilder: (context, index) {
                            final values = newlist[index];
                            ScreenTransaction st = const ScreenTransaction();
                            return values.ctype == CategoryType.expenses
                                ? Card(
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
                                              icon: Icons.delete,
                                            )
                                          ]),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          child:
                                              Text(st.parseDate(values.date)),
                                          backgroundColor: Colors.red,
                                        ),
                                        title: Text(values.purpose),
                                        subtitle:
                                            Text(values.amount.toString()),
                                      ),
                                    ),
                                  )
                                : Container();
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 10);
                          },
                          itemCount: newlist.length),
                    ),
                  );
                }),
          ],
        )));
  }
}
