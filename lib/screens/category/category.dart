import 'package:flutter/material.dart';
import 'package:moneymanagement_app/db/category_db.dart';
import 'package:moneymanagement_app/screens/category/list_expenses.dart';
import 'package:moneymanagement_app/screens/category/list_income.dart';


class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDb().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: [Tab(text: "Income"), Tab(text: "Expenses")],
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey[700],
        ),
        Expanded(
          child: TabBarView(
              controller: _tabController,
              children: [ScreenIncome(), ScreenExpenses()]),
        )
      ],
    );
  }
}
