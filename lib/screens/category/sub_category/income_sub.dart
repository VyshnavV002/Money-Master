import 'package:flutter/material.dart';
import 'package:moneymanagement_app/db/category_db.dart';
import 'package:moneymanagement_app/db/transaction_db.dart';

import 'package:moneymanagement_app/model/transaction_add.dart';
import 'package:moneymanagement_app/reusable_widgets/subincome_dash.dart';

import 'package:moneymanagement_app/screens/transaction/transaction.dart';

class RequiredValues {
  RequiredValues._internal();
  static RequiredValues instance = RequiredValues._internal();
  factory RequiredValues() {
    return instance;
  }

  String? value;
}

class ScreenSubIncome extends StatelessWidget {
  static const subincome = "sub-income";

  final String? idvalue = RequiredValues.instance.value;

  ScreenTransaction st = const ScreenTransaction();

  double sum = 0;

  @override
  Widget build(BuildContext context) {
    CategoryDb.instance.refreshUI();
    TransactionDb.instance.refreshUI();

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            SubIncomeDash.valueid.value = 0.0;
            Navigator.of(context).pop();
          },
        ),
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
