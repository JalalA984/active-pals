import 'dart:developer';

import 'package:active_pals/screens/services/auth.dart';
import 'package:active_pals/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: const Text("Sign in to ActivePals"),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Welcome to ActivePals",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20.0),
              PrimaryButton(
                text: "Sign in Anonymously",
                onPressed: () async {
                  dynamic result = await _auth.signInAnon();
                  if (result == null) {
                    log("Error signing in");
                  } else {
                    log("Signed in");
                    log(result.toString());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
