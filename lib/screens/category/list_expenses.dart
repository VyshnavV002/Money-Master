import 'package:flutter/material.dart';
import 'package:moneymanagement_app/db/category_db.dart';
import 'package:moneymanagement_app/db/transaction_db.dart';
import 'package:moneymanagement_app/model/category.dart';
import 'package:moneymanagement_app/reusable_widgets/subincome_dash.dart';
import 'package:moneymanagement_app/screens/category/sub_category/income_sub.dart';
import 'package:moneymanagement_app/screens/category/sub_category/sub_expense.dart';

class ScreenExpenses extends StatelessWidget {
  const ScreenExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDb().expenseListListener,
        builder: (BuildContext ctx, List<CategoryModal> newList, Widget? _) {
          return ListView.separated(
              itemBuilder: (ctx, index) {
                final varList = newList[index];
                return Card(
                    child: ListTile(
                        onTap: () {
                          RequiredValues.instance.value = varList.id;
                          TransactionDb.instance.getsum(varList.id);
                          Ctype.instance.type = varList.type;
                          Navigator.of(context)
                              .pushNamed(ScreenSubExpense.subexpense);
                        },
                        title: Text(varList.name),
                        trailing: IconButton(
                            onPressed: () {
                              CategoryDb().deletelist(varList.id);
                            },
                            icon: const Icon(Icons.delete))));
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(height: 10);
              },
              itemCount: newList.length);
        });
  }
}
