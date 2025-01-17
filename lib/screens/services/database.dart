

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  
  // Collection reference 
  final CollectionReference preferenceCollection = FirebaseFirestore.instance.collection("preferences");

  Future updateUserData(String workout, String name, int intensity) async {
    return await preferenceCollection.doc(uid).set({
      'workout': workout,
      'name': name,
      'intensity': intensity,
    });
  }
}