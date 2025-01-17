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
        actions: [IconButton(onPressed: () async {
          await _auth.signOut();
        }, icon: Icon(Icons.person))],
      ),
    );
  }
}
