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
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (err) {
      log(err.toString());
      return null;
    }
  }

  // Stream
  Stream<UserModel?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user));
  }

  // Sign in with Email + Password
  Future signWithEandP(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (err) {
      log(err.toString());
      return null;
    }
  }

  // Register with Email + Password
  Future registerWithEandP(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (err) {
      log(err.toString());
      return null;
    }
  }

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
