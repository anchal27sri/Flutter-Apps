import 'package:firebase_auth/firebase_auth.dart';
import 'package:mycoffeeapp/models/user.dart';
import 'package:mycoffeeapp/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create User object based on firebase user
  User _userFromFirebaseUser (FirebaseUser user) {
    return user != null ? User(uid: user.uid): null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
    //
    // _auth.onAuthStateChanged.map(_userFromFirebaseUser) is same as 
    // _auth.onAuthStateChanged.map((FirebaseUser user) => _userFromFirebaseUser(user)
  }

  //sign in 
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    } 
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);

    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }



  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      await DatabaseService(uid: user.uid).updateUserData('3', 'anchal', 100);
      return _userFromFirebaseUser(user);

    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }


  //sign out
  Future signOut() async {
    try{
      
      return await _auth.signOut();
    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }


}

