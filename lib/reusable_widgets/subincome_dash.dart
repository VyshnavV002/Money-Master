import 'package:flutter/material.dart';
import 'package:moneymanagement_app/db/transaction_db.dart';
import 'package:moneymanagement_app/model/category.dart';

class Ctype {
  Ctype._internal();
  static Ctype instance = Ctype._internal();
  factory Ctype() {
    return instance;
  }
  CategoryType? type;
}

 class SubIncomeDash extends StatefulWidget {
  const SubIncomeDash({
    super.key,
  });

  static ValueNotifier<double> valueid = ValueNotifier(0.0);

  @override
  State<SubIncomeDash> createState() => _SubIncomeDashState();
}

class _SubIncomeDashState extends State<SubIncomeDash> {


  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 5.0,
        ),
        height: 100,
        width: double.infinity,
        child: Card(
          color: Ctype.instance.type == CategoryType.income
              ? const Color.fromARGB(255, 126, 218, 129)
              : const Color.fromARGB(255, 231, 93, 83),
          elevation: 30,
          child: ValueListenableBuilder(
              valueListenable: SubIncomeDash.valueid,
              builder: (BuildContext context, double newvalue, Widget? _) {
                return Center(
                  child: Text("Total Amount: $newvalue",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                );
              }),
              
        ),
        );
  }
}
