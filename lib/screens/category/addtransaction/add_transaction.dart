import 'package:flutter/material.dart';
import 'package:moneymanagement_app/db/category_db.dart';
import 'package:moneymanagement_app/db/transaction_db.dart';
import 'package:moneymanagement_app/model/category.dart';
import 'package:moneymanagement_app/model/transaction_add.dart';

class TransactionAdd extends StatefulWidget {
  static const routeName = "add-transaction";
  const TransactionAdd({super.key});

  @override
  State<TransactionAdd> createState() => _TransactionAddState();
}

class _TransactionAddState extends State<TransactionAdd> {
  DateTime? selectedDate;
  String? selectedValue;
  CategoryType? type;
  CategoryModal? category;
  final purposeEditingController = TextEditingController();
  final amountEditingController = TextEditingController();
  @override
  void initState() {
    type = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(title: const Text("Add-Transaction")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: purposeEditingController,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Purpose",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      TextField(
                        controller: amountEditingController,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Amount",
                            border: OutlineInputBorder()),
                        keyboardType: TextInputType.number,
                      ),
                      TextButton.icon(
                        onPressed: () async {
                          final isDateNull = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now()
                                  .subtract(const Duration(days: 30)),
                              lastDate: DateTime.now()
                                  .add(const Duration(days: 365 * 2)));
                          if (isDateNull == null) {
                            return;
                          } else {
                            setState(() {
                              selectedDate = isDateNull;
                            });
                          }
                        },
                        icon: const Icon(Icons.calendar_month),
                        label: selectedDate == null
                            ? const Text("Select Date")
                            : Text(selectedDate.toString()),
                      ),
                      Row(children: [
                        Row(children: [
                          Radio(
                              value: CategoryType.income,
                              groupValue: type,
                              onChanged: (newvalue) {
                                setState(() {
                                  type = CategoryType.income;
                                  selectedValue = null;
                                });
                              }),
                          const Text("income"),
                        ]),
                        Row(children: [
                          Radio(
                              value: CategoryType.expenses,
                              groupValue: type,
                              onChanged: (newvalue) {
                                setState(() {
                                  type = CategoryType.expenses;
                                  selectedValue = null;
                                });
                              }),
                          const Text("Expenes")
                        ])
                      ]),
                      DropdownButton(
                          value: selectedValue,
                          items: (type == CategoryType.income
                                  ? CategoryDb().incomeListListener.value
                                  : CategoryDb().expenseListListener.value)
                              .map((e) {
                            return DropdownMenuItem(
                              value: e.id,
                              onTap: () {
                                category = e;
                              },
                              child: Text(e.name),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            if (newValue == null) {
                              return;
                            } else {
                              setState(() {
                                selectedValue = newValue;
                              });
                            }
                          },
                          hint: const Text("Select Category")),
                      ElevatedButton(
                          onPressed: () {
                            addValues();
                          },
                          child: const Text("Submit")),
                    ]),
              ),
            ),
          ),
        ));
  }

  Future<void> addValues() async {
    final purposeText = purposeEditingController.text;
    final amountText = amountEditingController.text;
    if (purposeText.isEmpty) {
      return;
    }
    if (amountText.isEmpty) {
      return;
    }
    if (selectedDate == null) {
      return;
    }
    if (category == null) {
      return;
    }
    final pareseamount = double.tryParse(amountText);
    if (pareseamount == null) {
      return;
    }
    final _model = AddTransaction(
        purpose: purposeText,
        amount: pareseamount,
        date: selectedDate!,
        ctype: type!,
        modal: category!);
    await TransactionDb.instance.addList(_model);
    TransactionDb.instance.refreshUI();
    Navigator.of(context).pop();
  }
}
