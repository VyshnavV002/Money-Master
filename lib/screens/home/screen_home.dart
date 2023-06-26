import 'package:flutter/material.dart';
import 'package:moneymanagement_app/reusable_widgets/drawer.dart';
import 'package:moneymanagement_app/screens/login/login_screen.dart';
import 'package:moneymanagement_app/screens/report/report_page.dart';

import 'package:moneymanagement_app/screens/category/addtransaction/add_transaction.dart';
import 'package:moneymanagement_app/screens/category/category.dart';
import 'package:moneymanagement_app/screens/category/category_add_popup.dart';
import 'package:moneymanagement_app/screens/home/navigation_file.dart';
import 'package:moneymanagement_app/screens/tax/tax_page.dart';
import 'package:moneymanagement_app/screens/transaction/transaction.dart';
import 'package:moneymanagement_app/screens/upi/upi_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  static const pagename = "home-screen";
  static ValueNotifier<int> selectedIndex = ValueNotifier(0);
  static const _pages = [
    ScreenTransaction(),
    ScreenCategory(),
    TaxCalculatorPage(),
    UpiPage(),
    ReportScreen()
  ];
  static ValueNotifier<int> index = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerScreen(),
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Money Master'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndex,
          builder: (BuildContext context, int updatedvalue, Widget? child) {
            return _pages[updatedvalue];
          },
        ),
      ),
      bottomNavigationBar: const MoneyNavigationBar(),
      floatingActionButton: ValueListenableBuilder(
        valueListenable: index,
        builder: (context, value, child) {
          if (value <= 1) {
            return FloatingActionButton(
                onPressed: () {
                  if (selectedIndex.value == 0) {
                    Navigator.of(context).pushNamed(TransactionAdd.routeName);
                  } else {
                    CategoryAddPopUp(context);
                  }
                },
                child: const Icon(Icons.add));
          }
          return Container();
        },
      ),
    );
  }
}
