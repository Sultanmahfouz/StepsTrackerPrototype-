import 'package:steps_tracker_prototype/models/collection.dart';
import 'package:steps_tracker_prototype/models/user.dart';

class UserService {
  final String uid;
  final String name;
  final String avatar;

  UserService({this.uid, this.name, this.avatar});

  // set user data to database
  Future setUserData(UserData userData) async {
    return await FirebaseCollection().users.doc(uid).set(userData.toMap());
  }

  // update user image
  Future updateUserData() async {
    return await FirebaseCollection().users.doc(uid).update({
      'avatar': avatar,
      'name': name,
    });
  }
}
