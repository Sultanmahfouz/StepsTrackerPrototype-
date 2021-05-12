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
  ) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User user = result.user;
    await UserService(
      uid: user.uid,
      name: name,
      avatar: avatar,
    ).setUserData(
      UserData(
        uid: user.uid,
        name: name,
        avatar: avatar,
      ),
    );
    return user != null
        ? UserData(
            uid: user.uid,
            name: name,
            avatar: avatar,
          )
        : null;
  }
}
