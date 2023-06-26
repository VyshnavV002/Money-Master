import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moneymanagement_app/screens/home/screen_home.dart';
import 'package:moneymanagement_app/screens/login/phone_login/verify.dart';

class PhoneLoginScreen extends StatelessWidget {
  PhoneLoginScreen({super.key});
  final phoneNoController = TextEditingController();
  final countryController = TextEditingController();
  static const phonelogin = "log-in";
  @override
  Widget build(BuildContext context) {
    sendCode() async {
      bool verificationfailed = false;
      showDialog(
          context: context,
          builder: ((context) => const Center(
              child: SizedBox(child: CircularProgressIndicator()))));
      FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNoController.text,
        verificationCompleted: (_) {},
        verificationFailed: (e) {
          verificationfailed = true;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message.toString())));
        },
        codeSent: (verificationId, token) {
          Navigator.push(
              context,
              ModalBottomSheetRoute(
                builder: (ctx) {
                  return VerifyPinScreen(
                    verificationId: verificationId,
                  );
                },
                isScrollControlled: true,
              ));
        },
        codeAutoRetrievalTimeout: (e) {
          if (verificationfailed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Time ran out")));
          }
        },
        timeout: const Duration(seconds: 30),
      );
      Navigator.pop(context);
    }

    return Scaffold(
        body: SafeArea(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("Enter your phone number for verification ",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
      const SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          controller: phoneNoController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
              label: Text("Phone Number"),
              hintText: "+countrycode",
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
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Back",
                style: TextStyle(fontSize: 16),
              ))
        ],
      )
    ])));
  }
}
