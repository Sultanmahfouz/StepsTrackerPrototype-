import 'package:firebase_auth/firebase_auth.dart';
import 'package:steps_tracker_prototype/models/user.dart';
import 'package:steps_tracker_prototype/services/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign up a user
  Future<UserData> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
    String avatar,
    String footSteps,
  ) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User user = result.user;
    await UserService(
      uid: user.uid,
      name: name,
      avatar: avatar,
      footSteps: footSteps,
    ).setUserData(
      UserData(
        uid: user.uid,
        name: name,
        avatar: avatar,
        footSteps: footSteps,
      ),
    );
    return user != null
        ? UserData(
            uid: user.uid,
            name: name,
            avatar: avatar,
            footSteps: footSteps,
          )
        : null;
  }

  // sign in a user
  Future<UserData> signInWithEmailAndPassword(
      String email, String password) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    User user = result.user;

    return user != null ? UserData(uid: user.uid) : null;
  }

  // sign in a user anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future signOutUser() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
