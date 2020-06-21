import 'dart:convert';

import 'file:///F:/Flutter%20Projetcs/delilo/lib/Screens/Buyer_home/Buyer_Initialpage.dart';
import 'package:delilo/Screens/authenticate/Owner_Login.dart';
import 'package:delilo/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  static final FacebookLogin facebookSignIn = new FacebookLogin();
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
      String id = user.uid;
      return id;
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

  Future<Null> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return BuyerInitPage();
        },
      ),
    );

  }

  void signOutGoogle() async{
    await googleSignIn.signOut();

    print("User Sign Out");
  }

  Future<Null> signInWithFB(BuildContext context) async {
    final FacebookLoginResult result =
    await facebookSignIn.logIn(['email']);
    print(result.status);
    switch (result.status)
    {
      case FacebookLoginStatus.error:
        return null;
        break;
      case FacebookLoginStatus.cancelledByUser:
        return null;
        break;
      case FacebookLoginStatus.loggedIn:
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.width(400)&access_token=${result
                .accessToken.token}');

        var profile = json.decode(graphResponse.body);
        print(profile.toString());
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return BuyerInitPage();
            },
          ),
        );

        break;
    }

  }

  Future<Null> SignOutFB() async {
    await facebookSignIn.logOut();
    print('Logged out.');
  }

}