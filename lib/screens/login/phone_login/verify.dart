import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moneymanagement_app/authentication/authentication.dart';
import 'package:moneymanagement_app/screens/home/screen_home.dart';

class VerifyPinScreen extends StatefulWidget {
  final verificationId;

  VerifyPinScreen({this.verificationId});
  static const verifyPage = "verify-page";
  static final codeController = TextEditingController();

  @override
  State<VerifyPinScreen> createState() => _VerifyPinScreenState();
}

class _VerifyPinScreenState extends State<VerifyPinScreen> {
  final codeController = TextEditingController();
  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sendCode() async {
      final credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId, smsCode: codeController.text);
      try {
        await FirebaseAuth.instance.signInWithCredential(credential);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message.toString())));
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Verification Page"),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text("Enter the code: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: codeController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    label: Text("Code"),
                    hintText: "6 digits",
                    border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: () async {
                sendCode();
              },
              child: const Text(
                "Verify",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
              ),
            ),
          ]),
        )));
  }
}
