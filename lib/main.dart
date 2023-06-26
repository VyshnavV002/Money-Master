import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moneymanagement_app/authentication/authentication.dart';
import 'package:moneymanagement_app/model/category.dart';
import 'package:moneymanagement_app/model/stock_db.dart';
import 'package:moneymanagement_app/screens/category/addtransaction/add_transaction.dart';
import 'package:moneymanagement_app/screens/category/sub_category/income_sub.dart';
import 'package:moneymanagement_app/screens/category/sub_category/sub_expense.dart';
import 'package:moneymanagement_app/screens/drawer/expense.dart';
import 'package:moneymanagement_app/screens/drawer/pie_screen.dart';
import 'package:moneymanagement_app/screens/drawer/stock_tracking.dart';
import 'package:moneymanagement_app/screens/home/screen_home.dart';
import 'package:moneymanagement_app/screens/login/Forgot_Password/forgot_password.dart';
import 'package:moneymanagement_app/screens/login/login_screen.dart';

import 'package:moneymanagement_app/model/transaction_add.dart';
import 'package:moneymanagement_app/screens/login/phone_login/phone_login.dart';
import 'package:moneymanagement_app/screens/login/phone_login/verify.dart';
import 'package:moneymanagement_app/screens/login/sign_up/register.dart';
import 'package:moneymanagement_app/screens/report/pdf_page.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryModalAdapter().typeId)) {
    Hive.registerAdapter(CategoryModalAdapter());
  }
  if (!Hive.isAdapterRegistered(AddTransactionAdapter().typeId)) {
    Hive.registerAdapter(AddTransactionAdapter());
  }
  if (!Hive.isAdapterRegistered(StockTrackerAdapter().typeId)) {
    Hive.registerAdapter(StockTrackerAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const AuthCheckPage(),
      routes: {
        LoginScreen.loginPage: (context) => LoginScreen(),
        TransactionAdd.routeName: (context) => const TransactionAdd(),
        HomeScreen.pagename: (context) => HomeScreen(),
        PdfScreen.pdfname: (context) => const PdfScreen(),
        ForgotPassPage.forgotpage: (context) => const ForgotPassPage(),
        RegisterPage.registerPage: (context) => RegisterPage(),
        PhoneLoginScreen.phonelogin: (context) => PhoneLoginScreen(),
        VerifyPinScreen.verifyPage: (context) => VerifyPinScreen(),
        StockScreen.stockscreen: (context) => StockScreen(),
        ExpenseTrackerScreen.expensescreen: (context) =>
            const ExpenseTrackerScreen(),
        ScreenSubIncome.subincome: (context) => ScreenSubIncome(),
        ScreenSubExpense.subexpense: (context) => ScreenSubExpense(),
        PieScreen.piescreen:(context)=>PieScreen()
      },
    );
  }
}
