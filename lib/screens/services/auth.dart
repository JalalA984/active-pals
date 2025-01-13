import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';


// Define all methods that interact with Firebase Auth
class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in Anonymously
  Future signInAnon() async {
    try {
      UserCredential result  = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    } catch (err) {
      log(err.toString());
      return null;
    }
  }


  // Sign in with Email + Password


  // Register with Email + Password


  // Sign Out
}