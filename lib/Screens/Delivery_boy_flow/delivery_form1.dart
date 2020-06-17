import 'package:delilo/Screens/Delivery_boy_flow/document_picker.dart';
import 'package:delilo/Screens/Image_picker.dart';
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

class DeliveryForm1 extends StatefulWidget
{
  @override
  _DeliveryForm1State createState() => _DeliveryForm1State();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
bool _autoValidate = false;

String _value;
final _firestore = Firestore.instance;
final _auth = FirebaseAuth.instance;
final AuthService _auth1 = AuthService();
var otp = new List(6);
String id;
bool check =false;

class _DeliveryForm1State extends State<DeliveryForm1>
{
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
                      color: Colors.blue,
                      onPressed: () async {
                        final code = _codeController.text.trim();
                        AuthCredential credential =
                        PhoneAuthProvider.getCredential(
                            verificationId: verificationId, smsCode: code);

                        AuthResult result =
                        await _auth.signInWithCredential(credential);

                        FirebaseUser user = result.user;
                        id = user.uid.toString();
                        if (user != null) {
                          check = true;
                          Navigator.of(context).pop();
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

  String error ='';
  String email ='';
  String pass ='';
  String name ='';
  String address ='';
  String idproof='';
  String accname='';
  String ifsc='';
  String driving ='';
  String pan='';
  String photo = '';
  String cheque = '';
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
                          'FORM',
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
                          height: 10,
                        ),
                        TextFormField(
                          validator: (val) => val.isEmpty ? 'Enter an Account namr' : null,
                          decoration: InputDecoration(
                            hintText: 'Account name',
                            prefixIcon: Icon(Icons.phone),
                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            border:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                          ),
                          onChanged: (val) {
                            setState(() => accname = val);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (val) => val.isEmpty ? 'Enter an IFSC Number' : null,
                          decoration: InputDecoration(
                            hintText: 'IFSC Number',
                            prefixIcon: Icon(Icons.phone),
                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            border:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                          ),
                          onChanged: (val) {
                            setState(() => ifsc = val);
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
                        Expanded(
                          child: TextFormField(
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
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RoundButoon(
                          color: Colors.green,
                          f: () async {
                            if(check)
                            {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                print(
                                    ' $name $address $phoneno $email');

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => DocumentPick(name,email,phoneno,address,id,idproof,accname,pan,ifsc,driving,cheque,photo,'ID proof')));
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
                          },
                          name: 'Continue..',
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
}