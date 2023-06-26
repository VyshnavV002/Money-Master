import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moneymanagement_app/screens/drawer/expense.dart';
import 'package:moneymanagement_app/screens/drawer/stock_tracking.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    String? displayName = currentUser?.displayName;
    String? phoneNumber = currentUser?.phoneNumber;
    return Drawer(
        child: ListView(padding: const EdgeInsets.only(top: 0), children: [
      UserAccountsDrawerHeader(
        accountName: Text(FirebaseAuth.instance.currentUser?.displayName ??
            FirebaseAuth.instance.currentUser?.phoneNumber ??
            " "),
        accountEmail: Text(FirebaseAuth.instance.currentUser?.email ?? ""),
      ),
      const SizedBox(height: 10),
      ListTile(
        enabled: true,
        leading: const Icon(Icons.shopping_cart),
        title: const Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Text("Stock Tracking"),
        ),
        onTap: () {
          Navigator.of(context).pushNamed(StockScreen.stockscreen);
        },
      ),
      const SizedBox(height: 10),
      ListTile(
        leading: const Icon(Icons.receipt),
        title: const Text("ExpenseTracker"),
        onTap: () {
          Navigator.of(context).pushNamed(ExpenseTrackerScreen.expensescreen);
        },
      ),
      const SizedBox(height: 10),
      ListTile(
        leading: const Icon(Icons.logout),
        title: const Text("SignOut"),
        onTap: () async {
          try {
            final auth = FirebaseAuth.instance;
            await auth.signOut();
          } on FirebaseAuthException catch (e) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.message.toString())));
          }
        },
      ),
    ]));
  }
}
