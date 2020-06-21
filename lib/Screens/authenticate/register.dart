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
final _auth = FirebaseAuth.instance;
final AuthService _auth1 = AuthService();
var otp = new List(6);
bool check =false;

class _RegisterScreenState extends State<RegisterScreen> {

  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  Future<bool> loginUser(String phone, BuildContext context) async {

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          if (user != null) {
            check = true;
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
                      color: Colors.green,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular((50))),
                      onPressed: () async {
                        final code = _codeController.text.trim();
                        AuthCredential credential =
                        PhoneAuthProvider.getCredential(
                            verificationId: verificationId, smsCode: code);

                        AuthResult result =
                        await _auth.signInWithCredential(credential);

                        FirebaseUser user = result.user;

                        if (user != null) {
                          check = true;
                          Navigator.of(context);
                        } else {
                          print("Error");
                          Fluttertoast.showToast(
                              msg: "Wrong OTP",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIos: 1,
//                                      backgroundColor: Colors.whi,
//                                      textColor: Colors.white,
                              fontSize: 10.0);
                        }
                      },
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: null);
  }

  String error ='';
  String email ='';
  String pass ='';
  String name ='';
  String address ='';
  String phoneno ='';
  var viewportHeight;
  var viewportWidth;

  @override
  Widget build(BuildContext context) {
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
                    child: Container(
                      height: 800,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 145,
                            width: 200,
                            decoration: BoxDecoration(
                              image:DecorationImage(
                                  image: AssetImage('images/logo.png')),
                            ),
                          ),
                          SizedBox(
                            height: 5,
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
                          SizedBox(
                            height: 5,
                          ),
                          new FlatButton(
                            onPressed: (){
                              final phone = phoneno.trim();

                              loginUser(phone, context);
                            },
                            child: Text('Send OTP',
                                style: TextStyle(color: Colors.green)),
                          ),
                          SizedBox(
                            height: 5,
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
                            obscureText: true,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[

                              Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: OutlineButton(
                                  splashColor: Colors.deepPurpleAccent,
                                  onPressed: () async{
                                    _auth1.signInWithFB(context).whenComplete(() {

                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40)),
                                  highlightElevation: 0,
                                  borderSide: BorderSide(color: Colors.grey),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image(image: AssetImage('images/j.png'), height: 20.0),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Register",
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
                              ),
                              // _signInButtonG() ,
                              Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: OutlineButton(
                                  splashColor: Colors.deepPurpleAccent,
                                  onPressed: () async {
                                    dynamic result = await _auth1.signInWithGoogle(context).whenComplete(() {

                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40)),
                                  highlightElevation: 0,
                                  borderSide: BorderSide(color: Colors.grey),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image(image: AssetImage('images/p.png'), height: 20.0),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Register",
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
                              ),

                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: RoundButoon(
                              color: Colors.green,
                              f: () async {
                                if(check)
                                  {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      print(
                                          '$name $name $address $phoneno $email $pass');

                                    try {
                                      final newUser =
                                      await _auth.createUserWithEmailAndPassword(
                                          email: email.trim(), password: pass);
                                      final user = newUser.user.uid.toString();
                                      if (newUser != null) {
                                        print('registered');
                                        DocumentReference res = await _firestore.collection('credentials').add({
                                          'Name': name,
                                          'Mobile': phoneno,
                                          'Email': email,
                                          'Address': address,
                                          'uid':user,
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
                                          MaterialPageRoute(builder: (context) => SignIn()),
                                        );
                                      }
                                    }
                                    catch(e){
                                      print("$e");
                                    }
                                  }
                                else
                                  {
                                    new AlertDialog(
                                      title: Text('OTP incorrect'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            Text('Otp provided is incorrect. Please try again !!'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('Approve'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  }
                              }},
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
                            child: Text('Already have an Account ? Sign In',
                                style: TextStyle(color: Colors.black)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]
        )

    );
  }
}