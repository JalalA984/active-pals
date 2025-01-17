import 'dart:developer';

import 'package:active_pals/screens/services/auth.dart';
import 'package:active_pals/widgets/constants.dart';
import 'package:active_pals/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: const Text("Sign in to ActivePals"),
        actions: [
          TextButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: const Icon(Icons.person, color: Colors.black),
              label: const Text(
                "Register",
                style: TextStyle(color: Colors.black),
              )),
        ],
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
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: "Email"),
                        validator: (val) =>
                            val!.isEmpty ? "Enter an email" : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: "Password"),
                        obscureText: true,
                        validator: (val) => val!.length < 6
                            ? "Enter a password with 6+ characters"
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      PrimaryButton(
                          text: "Sign in",
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              log("sign in button press form validate passed");
                              dynamic result =
                                  await _auth.signWithEandP(email, password);
                              if (result == null) {
                                log("sign in FAIL on firebase auth backend");
                                setState(() =>
                                    error = "Email and/or password incorrect");
                              }
                            }
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.pink),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
