import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:moneymanagement_app/authentication/authentication.dart";
import "package:moneymanagement_app/reusable_widgets/image_login.dart";
import 'package:google_sign_in/google_sign_in.dart';
import "package:moneymanagement_app/screens/home/screen_home.dart";
import "package:moneymanagement_app/screens/login/Forgot_Password/forgot_password.dart";
import "package:moneymanagement_app/screens/login/phone_login/phone_login.dart";
import "package:moneymanagement_app/screens/login/sign_up/register.dart";

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
  static const loginPage = "Login-Page";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static final usernameController = TextEditingController();
  static final paswwordController = TextEditingController();
  userNameErrorMessage(FirebaseException e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.message.toString())));
  }

  @override
  Widget build(BuildContext context) {
    signInGoogle() async {
      showDialog(
          context: context,
          builder: ((context) => const Center(
              child: SizedBox(child: CircularProgressIndicator()))));

      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      Navigator.of(context).pop();
      final credential = GoogleAuthProvider.credential(
          idToken: gAuth.idToken, accessToken: gAuth.accessToken);

      return FirebaseAuth.instance.signInWithCredential(credential);
    }

    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: const ImageGenrator()),
        const SizedBox(
          height: 10,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(ForgotPassPage.forgotpage);
                      },
                      child: const Text("Forgot Password?"))
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      });
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: usernameController.text,
                        password: paswwordController.text);
                  } on FirebaseAuthException catch (e) {
                    userNameErrorMessage(e);
                  }
                  Navigator.pop(context);
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                ),
              ),
              const SizedBox(height: 18),
              const Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Divider(
                      thickness: 0.6,
                      color: Colors.grey,
                    ),
                  )),
                  Text(" or Connect by "),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Divider(
                      thickness: 0.6,
                      color: Colors.grey,
                    ),
                  )),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        signInGoogle();
                      },
                      child: const Image(
                          image: AssetImage('assets/images/google.png'))),
                  const SizedBox(
                    width: 29,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(PhoneLoginScreen.phonelogin);
                      },
                      child: const Image(
                          image: AssetImage('assets/images/phone.png')))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Dont Have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(RegisterPage.registerPage);
                      },
                      child: Text("Signup"))
                ],
              )
            ],
          ),
        ))
      ]),
    )));
  }
}
