import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moneymanagement_app/screens/login/login_screen.dart';
import 'package:moneymanagement_app/screens/login/phone_login/phone_login.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});
  static const forgotpage = 'forgot-page';

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  final passresetMailController = TextEditingController();

  signInEmail() async {
    showDialog(
        context: context,
        builder: ((context) =>
            const Center(child: SizedBox(child: CircularProgressIndicator()))));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: passresetMailController.text);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Mail Sucessfully sent")));
      Navigator.pop(context);
      Navigator.of(context).pushNamed(LoginScreen.loginPage);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(content: Text(e.message.toString()), actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Center(
                  child: Text(
                    "OK",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 15,
                    ),
                  ),
                ),
              )
            ]);
          });
    }
  }

  @override
  void dispose() {
    passresetMailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
              child: Image(
                image: AssetImage('assets/images/passwordreset.png'),
                width: 200,
              ),
            ),
            const Text("Enter your email to send password reset mail ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: passresetMailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("E-mail"),
                    hintText: "example@gmail.com"),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () async {
                signInEmail();
              },
              child: const Text(
                "Send Mail",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
