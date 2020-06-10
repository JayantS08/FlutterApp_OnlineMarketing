import 'package:delilo/Screens/Initial_Screen.dart';
import 'package:delilo/Screens/authenticate/register.dart';
import 'package:delilo/Screens/authenticate/Buyer_Login.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView(){
    //print(showSignIn.toString());
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView,);
    } else {
      return RegisterScreen(toggleView: toggleView,);
    }
  }
}