class UserModel {
  final String uid;

  UserModel({required this.uid});

  @override
  String toString() {
    return 'UserModel(uid: $uid)';
  }
}

class UserDataModel {
  final String uid;
  final String name;
  final String workout;
  final int intensity;

  UserDataModel({required this.uid, required this.name, required this.workout, required this.intensity});
  
}