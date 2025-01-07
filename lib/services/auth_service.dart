import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Private constructor to restrict instantiation
  AuthService._privateConstructor();

  // The single instance of the class
  static final AuthService instance = AuthService._privateConstructor();
  static final FirebaseAuth _authInst = FirebaseAuth.instance;

  Future<String?> signUp(
      {required String email, required String password}) async {
    String? message;

    try {
      await _authInst.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The email is already registered';
      } else {
        message = 'Unexpected issue, please try later';
      }
      return message;
    } catch (e) {
      message = 'Unexpected issue, please try later';
    }
    return message;
  }

  Future<String?> signIn(
      {required String email, required String password}) async {
    String? message;

    try {
      await _authInst.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        message = 'The email or password is wrong.';
      } else {
        message = 'Unexpected issue, please try later';
      }
      return message;
    } catch (e) {
      message = 'Unexpected issue, please try later';
    }
    return message;
  }

  Future<String?> signOut() async {
    String? message;

    try {
      _authInst.signOut();
    } on FirebaseAuthException {
      message = 'Unexpected issue, please try later';
    } catch (e) {
      message = 'Unexpected issue, please try later';
    }

    return message;
  }

  bool isUserLoggedIn() {
    User? currentUser = _authInst.currentUser;
    FirebaseAuth.instance.currentUser == null
        ? 'user doesn\'nt sign in'
        : 'user is signed in';
    // Return true if a user is logged in, otherwise false
    return currentUser != null;
  }

  String? getUserId() {
    User? currentUser = _authInst.currentUser;
    if (currentUser != null) {
      return currentUser.uid;
    }
    return null;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _authInst.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }
}
