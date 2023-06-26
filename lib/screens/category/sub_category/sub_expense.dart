import 'package:flutter/material.dart';
import 'package:moneymanagement_app/db/category_db.dart';
import 'package:moneymanagement_app/db/transaction_db.dart';
import 'package:moneymanagement_app/model/category.dart';
import 'package:moneymanagement_app/model/transaction_add.dart';
import 'package:moneymanagement_app/reusable_widgets/subincome_dash.dart';
import 'package:moneymanagement_app/screens/category/sub_category/income_sub.dart';
import 'package:moneymanagement_app/screens/transaction/transaction.dart';

class ScreenSubExpense extends StatelessWidget {
 ScreenSubExpense({super.key});
  static const subexpense = "sub-expense";
  String? idvalue = RequiredValues.instance.value;
   ScreenTransaction st = const ScreenTransaction();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Income-Subcategory"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SubIncomeDash(),
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: TransactionDb.instance.transactionList,
                  builder: (BuildContext ctx, List<AddTransaction> newList,
                      Widget? _) {
                    return SizedBox(
                      height: 400,
                      child: ListView.separated(
                          padding: const EdgeInsets.all(10),
                          itemBuilder: (ctx, index) {
                            final values = newList[index];
            
                            return values.modal.id == idvalue
                                ? Card(
                                    elevation: 30,
                                    child: ListTile(
                                      title: Text(values.purpose),
                                      leading: CircleAvatar(
                                        child: Text(st.parseDate(values.date)),
                                      ),
                                      subtitle: Text(values.amount.toString()),
                                    ))
                                : Container();
                          },
                          separatorBuilder: (ctx, index) {
                            return const SizedBox(height: 10);
                          },
                          itemCount: newList.length),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
