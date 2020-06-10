import 'package:delilo/Screens/authenticate/Owner_Login.dart';
import 'package:delilo/Screens/authenticate/register.dart';
import 'package:delilo/services/auth.dart';
import 'package:flutter/material.dart';
//import 'package:google_sign_in/google_sign_in.dart';



Widget _signInButtonF(String title, String img, String method) {
  return Padding(
    padding: const EdgeInsets.only(top: 18.0),
    child: OutlineButton(
      splashColor: Colors.deepPurpleAccent,
      onPressed: () {
        /*if (method == "google") {
          SignIn1()
              .then((FirebaseUser user) =>
              print('After button pressed ${user}'))
              .catchError((e) => print(e));
        } else {
          print('Fb not yet implemented');
        }*/
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage(img), height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[

                  SizedBox(height: 30.0,),
                  SizedBox(height: 12.0),
                  Text("LOGIN",style: TextStyle(fontSize: 30),),
                  SizedBox(height: 12.0),
                  TextFormField(
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
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
                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    ),
                    validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  SizedBox(height: 12.0),
                  RaisedButton(
                      color: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                          if(result == null) {
                            setState(() {
                              error = 'Could not sign in with those credentials';
                            });
                          }
                          else
                            {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => owner()),
                              );
                            }

                        }
                      }
                  ),
                  SizedBox(height: 12.0),
                  FlatButton(
                    onPressed: () {},
                    child: Text('Or login by Mobile Number',
                        style: TextStyle(color: Colors.black)),
                  ),
                  SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      // _signInButtonG() ,
                      _signInButtonF('Login', 'images/j.png', 'fb'),
                      _signInButtonF('Login', 'images/p.png', 'google'),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  new FlatButton(
                    onPressed: ()
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
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
