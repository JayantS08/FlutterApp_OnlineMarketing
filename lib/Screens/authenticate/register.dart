import 'package:delilo/Screens/authenticate/Buyer_Login.dart';
import 'package:delilo/Screens/authenticate/Owner_Login.dart';
import 'package:delilo/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:delilo/utils/buttons.dart';
import 'package:delilo/utils/const.dart';
import 'package:delilo/helpers/dimensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  final Function toggleView;
  RegisterScreen({ this.toggleView });

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
bool _autoValidate = false;
String _value;
final _firestore = Firestore.instance;

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;
  String error ='';
  var viewportHeight;
  var viewportWidth;

  @override
  Widget build(BuildContext context) {
    String email ='';
    String pass ='';
    String name ='';
    String address ='';
    String phoneno ='';
    viewportHeight = getViewportHeight(context);
    viewportWidth = getViewportWidth(context);
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(
            children: <Widget>[
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
                key: _formKey,
                autovalidate: _autoValidate,
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery
                            .of(context)
                            .size
                            .height),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Register',
                          style: TextStyle(fontSize: 40),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (val) => val.isEmpty ? 'Enter an Name' : null,
                          decoration: InputDecoration(
                            hintText: 'Name',
                            prefixIcon: Icon(Icons.person),
                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            border:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                          ),
                          onChanged: (val) {
                            setState(() => name = val);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (val) => val.isEmpty ? 'Enter an Mobile Number' : null,
                          decoration: InputDecoration(
                            hintText: 'Mobile Number',
                            prefixIcon: Icon(Icons.phone),
                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            border:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                          ),
                          onChanged: (val) {
                            setState(() => phoneno = val);
                          },
                        ),

                        _otpWidget(),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                'Resend OTP',
                                style: TextStyle(
                                    color: Colors.green, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (val) => val.isEmpty ? 'Enter an Address' : null,
                          decoration: InputDecoration(
                            hintText: 'Address',
                            prefixIcon: Icon(Icons.person_pin_circle),
                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            border:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                          ),
                          onChanged: (val) {
                            setState(() => address = val);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (val) => val.isEmpty ? 'Enter your Password' : null,
                          decoration: InputDecoration(
                            hintText: 'password',
                            prefixIcon: Icon(Icons.lock),
                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            border:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                          ),
                          onChanged: (val) {
                            setState(() => pass = val);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: RoundButoon(
                            color: Colors.deepPurple,
                            f: () async {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                print(
                                    '$name $name $address $phoneno $email $pass');

                                try {
                                  final newUser =
                                  await _auth.createUserWithEmailAndPassword(
                                      email: email.trim(), password: pass);
                                  if (newUser != null) {
                                    print('registered');
                                    DocumentReference res = await _firestore.collection('credentials').add({
                                      'Name': name,
                                      'Mobile': phoneno,
                                      'Email': email,
                                      'Address': address,
                                    });
                                    print(res.documentID);
                                    _auth.signOut();
                                    Fluttertoast.showToast(
                                        msg: "Registration Successful",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIos: 1,
//                                      backgroundColor: Colors.whi,
//                                      textColor: Colors.white,
                                        fontSize: 10.0);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => owner()),
                                    );
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              }
                            },
                            name: 'Login',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        new FlatButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignIn()),
                            );
                          },
                          child: Text('Already have an Acoont ? Sign In',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]
        )

    );
  }


  Widget circle() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(viewportHeight * 01),
      child: Container(
          height: viewportHeight * 0.05,
          width: viewportHeight * 0.05,
          color: Colors.grey),
    );
  }

  Widget _otpWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text('OTP Received'),
        circle(),
        circle(),
        circle(),
        circle(),
      ],
    );
  }
}