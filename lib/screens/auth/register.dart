import 'dart:developer';

import 'package:active_pals/screens/services/auth.dart';
import 'package:active_pals/widgets/primary_button.dart';
import 'package:active_pals/widgets/secondary_button.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";

  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[300],
        elevation: 0.0,
        title: const Text("Sign up for ActivePals"),
        actions: [
          TextButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: const Icon(Icons.person, color: Colors.black),
              label: const Text(
                "Sign in",
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
                "Register for ActivePals",
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
                      SecondaryButton(
                          text: "Sign up",
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              log("register button press form validate passed");
                              dynamic result = await _auth.registerWithEandP(
                                  email, password);
                              if (result == null) {
                                log("register process FAIL on firebase auth backend");
                                setState(() => error =
                                    "Please supply a valid email and/or password");
                              }
                            }
                          }),
                          SizedBox(height: 20,),
                          Text(error, style: TextStyle(color: Colors.pink),)
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
