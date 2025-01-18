import 'package:active_pals/models/Pal.dart';
import 'package:active_pals/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid = ""});

  // Collection reference
  final CollectionReference preferenceCollection =
      FirebaseFirestore.instance.collection("preferences");

  Future updateUserData(String workout, String name, int intensity) async {
    return await preferenceCollection.doc(uid).set({
      'workout': workout,
      'name': name,
      'intensity': intensity,
    });
  }

  // Get pals/preference list from snapshot
  List<Pal> _palsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>; // Safely cast the data
      return Pal(
        name: data['name'] ?? '',
        workout: data['workout'] ?? '',
        intensity: data['intensity'] ?? 0,
      );
    }).toList(); // Ensure `.toList()` is called to convert the map to a List
  }

  // Get a preference stream
  Stream<List<Pal>> get preferences {
    return preferenceCollection.snapshots().map(_palsListFromSnapshot);
  }

  // userDataModel from snapshot
  UserDataModel _userDataFromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return UserDataModel(
      uid: uid,
      name: data['name'] ?? '',
      workout: data['workout'] ?? '',
      intensity: data['intensity'] ?? 100,
    );
  }

  // Get the users document stream
  Stream<UserDataModel> get userData {
    return preferenceCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
