import 'file:///F:/Flutter%20Projetcs/delilo/lib/Screens/Buyer_home/Buyer_Initialpage.dart';
import 'package:delilo/Screens/authenticate/MobSignUP.dart';
import 'package:delilo/Screens/authenticate/Owner_Login.dart';
import 'package:delilo/Screens/authenticate/owner_form.dart';
import 'package:delilo/Screens/authenticate/register.dart';
import 'package:delilo/Screens/owner_home/Drawer/owner_menu.dart';
import 'package:delilo/Screens/owner_home/Menu.dart';
import 'package:delilo/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class OwnerLogin extends StatefulWidget {
  @override
  _OwnerLoginState createState() => _OwnerLoginState();
}

final AuthService _auth = AuthService();

class _OwnerLoginState extends State<OwnerLogin> {
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/back.png"),
              fit: BoxFit.cover,
              //colorFilter: ColorFilter.mode(Color.fromRGBO(192, 234, 218,1).withOpacity(0.6), BlendMode.softLight),
            ),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[

                  SizedBox(height: 30.0,),

                  Container(
                    height: 145,
                    width: 200,
                    decoration: BoxDecoration(
                      image:DecorationImage(
                          image: AssetImage('images/logo.png')),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text("LOGIN", style: TextStyle(fontSize: 30),),
                  SizedBox(height: 12.0),
                      TextFormField(
                        validator: (val) => val.isEmpty ? 'Enter a username' : null,
                        decoration: InputDecoration(
                          hintText: 'Username',
                          prefixIcon: Icon(Icons.email),
                          contentPadding: EdgeInsets.fromLTRB(
                              20.0, 15.0, 20.0, 15.0),
                          border:
                          OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                        ),
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),

                  SizedBox(height: 12.0),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline),
                      contentPadding: EdgeInsets.fromLTRB(
                          20.0, 10.0, 20.0, 10.0),
                      border:
                      OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                    validator: (val) =>
                    val.length < 6
                        ? 'Enter a password 6+ chars long'
                        : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  SizedBox(height: 12.0),
                  RaisedButton(
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          email = email+'@delilo.com';
                          AuthResult result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          String id = result.user.uid.toString();
                          if (result == null) {
                            setState(() {
                              error =
                              'Could not sign in with those credentials';
                            });
                          }
                          else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => OwnerMenu(id)),
                            );
                          }
                        }
                      }
                  ),
                  SizedBox(height: 20.0),
                  new FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OwnerForm()),
                      );
                    },
                    child: Text('Not a member? Sign up now',
                        style: TextStyle(color: Colors.black)),
                  ),

                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}