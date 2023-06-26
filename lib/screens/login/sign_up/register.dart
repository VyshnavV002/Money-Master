import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  static const registerPage = "register-page";
  final usernameController = TextEditingController();
  final paswwordController = TextEditingController();
  final confirmPaswwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    showErrorMessage() {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Check Password")));
    }

    createUser() async {
      if (confirmPaswwordController.text == paswwordController.text) {
        try {
         await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: usernameController.text,
              password: paswwordController.text);
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Account Created")));
        } on FirebaseAuthException catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message.toString())));
        }
      } else {
        showErrorMessage();
      }
    }

    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(
          height: 20,
        ),
        Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: const Text("Sign Up",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 50,
                    fontWeight: FontWeight.w700))),
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
          child: Text("Create account by filling out the fields ",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        ),
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    label: Text("Username"),
                    hintText: "Enter Email",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: paswwordController,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Password",
                      border: OutlineInputBorder()),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: confirmPaswwordController,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Confirm password",
                      border: OutlineInputBorder()),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 18),
              ElevatedButton(
                onPressed: () async {
                  createUser();
                },
                child: const Text(
                  "Register",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
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
            ],
          ),
        ))
      ]),
    )));
  }
}
