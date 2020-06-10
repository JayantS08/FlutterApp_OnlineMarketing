import 'package:delilo/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';



class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user)
  {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<String> get onAuthStateChanged => _auth.onAuthStateChanged.map(
        (FirebaseUser user) => user?.uid,
  );

  Stream<User> get user
  {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Future sendPasswordResetEmail(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    }
    catch(error){
      print("error");
      return null;
    }
  }

  signIn(AuthCredential authCreds) async{
    try
    {
      AuthResult res = await _auth.signInWithCredential(authCreds);
      FirebaseUser user = res.user;
      print(user);
      return user;
    }
    catch(e) {
      print('okk2');
      return null;
    }
  }

  signInWithOTP(smsCode, verId) async{
    AuthCredential authCreds = PhoneAuthProvider.getCredential (
        verificationId: verId, smsCode: smsCode);
    FirebaseUser use = await signIn(authCreds);
    print(use);
    return use;

  }
}