import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moneymanagement_app/model/category.dart';

part 'transaction_add.g.dart';

@HiveType(typeId: 3)
class AddTransaction {
  @HiveField(0)
  final String purpose;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final CategoryType ctype;
  @HiveField(4)
  final CategoryModal modal;
  @HiveField(5)
  String? id;
  AddTransaction(
      {required this.purpose,
      required this.amount,
      required this.date,
      required this.ctype,
      required this.modal}) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }

}
