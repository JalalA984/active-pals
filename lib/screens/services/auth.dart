import 'dart:developer';

import 'package:active_pals/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';


// Define all methods that interact with Firebase Auth
class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create User object based on Firebase User
  UserModel? _userFromFirebaseUser(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  // Sign in Anonymously
  Future signInAnon() async {
    try {
      UserCredential result  = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (err) {
      log(err.toString());
      return null;
    }
  }

  // Stream
  Stream<UserModel?> get user {
    return _auth.authStateChanges()
      .map((User? user) => _userFromFirebaseUser(user));
  }



  // Sign in with Email + Password


  // Register with Email + Password


  // Sign Out
  Future signOut() async {
    try {
      log("attempting to sign out");
      return await _auth.signOut();
    } catch (err) {
      log(err.toString());
    }
  }
}