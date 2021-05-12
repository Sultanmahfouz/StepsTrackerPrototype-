import 'package:steps_tracker_prototype/models/collection.dart';
import 'package:steps_tracker_prototype/models/user.dart';

class UserService {
  final String uid;
  final String name;
  final avatar;

  UserService({this.uid, this.name, this.avatar});

  // set user data to database
  Future setUserData(UserData userData) async {
    return await FirebaseCollection().users.doc(uid).set(userData.toMap());
  }
}
