import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:steps_tracker_prototype/models/collection.dart';
import 'package:steps_tracker_prototype/models/user.dart';

class UserService {
  final String uid;
  final String name;
  final String avatar;
  final String footSteps;

  UserService({this.uid, this.name, this.avatar, this.footSteps});

  // set user data to database
  Future setUserData(UserData userData) async {
    return await FirebaseCollections().users.doc(uid).set(userData.toMap());
  }

  // update user image and name
  Future updateUserData() async {
    return await FirebaseCollections().users.doc(uid).update({
      'avatar': avatar,
      'name': name,
    });
  }

  // update user number of steps
  Future updateUserDataSteps(String numberOfSteps) async {
    return await FirebaseCollections().users.doc(uid).update({
      'footSteps': numberOfSteps,
    });
  }

  UserData _userFromFirebaseUser(User user) {
    return user != null ? UserData(uid: user.uid) : null;
  }

  Stream<UserData> get user {
    // ignore: deprecated_member_use
    return FirebaseAuth.instance.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Stream<UserData> getUserDocument(String uid) {
    return FirebaseCollections().users.doc(uid).snapshots().map(
        (DocumentSnapshot snapshot) => UserData.fromMap(snapshot.data()) ?? '');
  }

  List<UserData> _usersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserData.fromMap(doc.data());
    }).toList();
  }

  Stream<List<UserData>> getUsersFootSteps() {
    return FirebaseCollections().users.snapshots().map(_usersListFromSnapshot);
  }
}
