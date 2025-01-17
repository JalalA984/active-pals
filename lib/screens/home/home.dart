import 'package:active_pals/screens/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: Text("ActivePals"),
        backgroundColor: Colors.blue[400],
        actions: [
          TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: const Icon(Icons.person, color: Colors.black),
              label: const Text(
                "Logout",
                style: TextStyle(color: Colors.black),
              )),
        ],
      ),
    );
  }
}
