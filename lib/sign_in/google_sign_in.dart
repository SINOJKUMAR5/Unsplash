import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:sign_in_button/sign_in_button.dart';
import 'package:unsplash/home_page.dart';

class google_sign_in extends StatefulWidget {
  const google_sign_in({super.key});

  @override
  State<google_sign_in> createState() => _google_sign_inState();
}

class _google_sign_inState extends State<google_sign_in> {
  TextEditingController phone_number_controller = TextEditingController();

  TextEditingController pin_code_controller = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  User? user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    auth.authStateChanges().listen((event) {
      setState(() {
        user = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: user != null ? const home_page() : sign_in(),
    );
  }

  // ignore: non_constant_identifier_names
  Widget sign_in() {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("Sign in "),
        const SizedBox(
          height: 20,
        ),
        SignInButton(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          Buttons.google,
          onPressed: () {
            google();
          },
        ),
        SignInButton(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          Buttons.apple,
          onPressed: () {
            google();
          },
        ),
        const Text("or"),
        ElevatedButton(
          onPressed: () {
            show_dilog();
          },
          style: const ButtonStyle(),
          child: const Icon(Icons.phone),
        )
      ]),
    );
  }

  // ignore: non_constant_identifier_names
  show_dilog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Enter phone number"),
            content: TextField(
              controller: phone_number_controller,
            ),
            actions: [
              TextButton(
                child: const Text("ok"),
                onPressed: () {
                  auth.verifyPhoneNumber(
                      phoneNumber: phone_number_controller.text.toString(),
                      verificationCompleted: (AuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {},
                      codeSent: (String verificationId, int? resent) {
                        pin_code(verificationId);
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {});
                },
              )
            ],
          );
        });
  }

  // ignore: non_constant_identifier_names
  pin_code(String verificationId) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Enter your code,"),
            content: TextField(controller: pin_code_controller),
            actions: [
              TextButton(
                  onPressed: () {
                    sign_in_phone(verificationId);
                  },
                  child: const Text("sign_in"))
            ],
          );
        });
  }

  // ignore: non_constant_identifier_names
  sign_in_phone(String verificationId) {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: pin_code_controller.text.toString());
    try {
      auth.signInWithCredential(credential);
    } catch (f) {
      print(f);
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const home_page();
    }));
  }

  google() {
    try {
      GoogleAuthProvider provider = GoogleAuthProvider();
      auth.signInWithProvider(provider);
    } catch (e) {
      print(e.toString());
    }
  }

  // ignore: non_constant_identifier_names
  sign_out() {
    auth.signOut();
  }
}
