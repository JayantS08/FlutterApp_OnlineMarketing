import 'package:delilo/Screens/Buyer_home/Buyer_Initialpage.dart';
import 'package:delilo/Screens/authenticate/Buyer_Login.dart';
import 'package:delilo/Screens/authenticate/Owner_Login.dart';
import 'package:delilo/utils/buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:delilo/helpers/dimensions.dart';

class LoginScreen extends StatelessWidget {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  Future<bool> loginUser(String phone, BuildContext context) async {

    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          if (user != null) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => BuyerInitPage()));
          } else {
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (AuthException exception) {
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Give the code?"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Confirm"),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () async {
                        final code = _codeController.text.trim();
                        AuthCredential credential =
                            PhoneAuthProvider.getCredential(
                                verificationId: verificationId, smsCode: code);

                        AuthResult result =
                            await _auth.signInWithCredential(credential);

                        FirebaseUser user = result.user;

                        if (user != null) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => BuyerInitPage()));
                        } else {
                          print("Error");
                        }
                      },
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: null);
  }
  var viewportHeight;
  var viewportWidth;
  @override
  Widget build(BuildContext context) {
    viewportHeight = getViewportHeight(context);
    viewportWidth = getViewportWidth(context);
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/back.png"),
                fit: BoxFit.cover,
                //colorFilter: ColorFilter.mode(Color.fromRGBO(192, 234, 218,1).withOpacity(0.6), BlendMode.softLight),
              ),
            ),
          ),
          Form(
            child: SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height),
                    child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 200,
                            width: 250,
                            decoration: BoxDecoration(
                              image:DecorationImage(
                                  image: AssetImage('images/logo.png')),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 36,
                                fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Mobile Number',
                              prefixIcon: Icon(Icons.phone_android),
                              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              border:
                              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                            ),
                            controller: _phoneController,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            width: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle
                            ),
                            child: RoundButoon(
                              name:"LOGIN",
                              f: () {
                                final phone = _phoneController.text.trim();

                                loginUser(phone, context);
                              },
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          new FlatButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn()),
                              );
                            },
                            child: Text('Or Login by Email-ID',
                                style: TextStyle(color: Colors.black)),
                          ),
                        ]))),
          ),
        ]));
  }
}
