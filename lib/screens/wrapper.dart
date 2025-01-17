import 'package:active_pals/models/user_model.dart';
import 'package:active_pals/screens/auth/authenticate.dart';
import 'package:active_pals/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final theUser = Provider.of<UserModel?>(context);
    
    if (theUser == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}