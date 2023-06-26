import 'package:flutter/material.dart';

import 'package:moneymanagement_app/screens/home/screen_home.dart';

class MoneyNavigationBar extends StatelessWidget {
  const MoneyNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HomeScreen.selectedIndex,
      builder: (BuildContext context, int updatedvalue, Widget? _) {
   return BottomNavigationBar(
  currentIndex: updatedvalue,
  items: [
    BottomNavigationBarItem(
      icon: Icon(Icons.currency_rupee),
      label: "Transactions",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.category),
      label: "Category",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.calculate),
      label: "Tax",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.payment),
      label: "Payment",
    ),
    BottomNavigationBarItem(icon: Icon(Icons.analytics),
    label: "Report")
  
  ],
  unselectedItemColor: Colors.grey,
  selectedItemColor: Colors.red,
  onTap: (newIndex) {
    HomeScreen.selectedIndex.value = newIndex;
    HomeScreen.index.value = newIndex;
  },
);

      },
    );
  }
}
