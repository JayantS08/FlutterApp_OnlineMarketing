import 'package:delilo/Screens/Signature.dart';
import 'package:delilo/Screens/cheque_picker.dart';
import 'package:delilo/utils/buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:delilo/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BankDetails extends StatefulWidget {
  String id;

  BankDetails(this.id);

  @override
  _BankDetailsState createState() => _BankDetailsState(id);
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
bool _autoValidate = false;


final _auth = FirebaseAuth.instance;
final _firestore = Firestore.instance;
final AuthService _auth1 = AuthService();

class _BankDetailsState extends State<BankDetails> {
  String id;

  _BankDetailsState(this.id);

  String name;
  String accno;
  String ifsc;

  @override
  Widget build(BuildContext context) {
    bool val1 = false;
    String hint = "";
    int _radioValue = 0;

    _drawcheck() {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Center(
            child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 75.0),
            ),
            Checkbox(
              activeColor: Colors.green,
              value: val1,
              onChanged: (bool value) {
                setState(() {
                  val1 = value;
                });
              },
            ),
            Text("I dont have IFSC code")
          ],
        ));
      });
    }

    Future<String> inputData() async {
      final FirebaseUser user = await _auth.currentUser();
      final us = user.uid;
      return us;
      // here you write the codes to input the data into firestore
    }

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
            key: _formKey,
            autovalidate: _autoValidate,
            child: SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height),
                    child: Column(children: <Widget>[
                      SizedBox(
                        height: 2,
                      ),
                      Container(
                        height: 150,
                        width: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/logo.png')),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "GIVE YOUR BANK DETAILS",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 36,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (val) => val.isEmpty ? "Enter account Holder's name" : null,
                        decoration: InputDecoration(
                          hintText: "Enter account Holder's name",
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                        ),
                        onChanged: (val) {
                          setState(() => name = val);
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        validator: (val) => val.isEmpty ? 'Enter Account number' : null,
                        decoration: InputDecoration(
                          hintText: "Enter bank account number",
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                        ),
                        onChanged: (val) {
                          setState(() => accno = val);
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'IFSC Number',
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                        ),
                        onChanged: (val) {
                          setState(() => ifsc = val);
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      _drawcheck(),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 180,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: RoundButoon(
                          name: "Continue",
                          f: () async {
                            print(id);
                            print(accno);
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              print(' $name $accno $ifsc ');

                              if (val1) {
                                print('registered');
                                DocumentReference res = await _firestore
                                    .collection('Account Details')
                                    .add({
                                  "Account Holder's name": name,
                                  "Account Number": accno,
                                  "IFSC Code": null,
                                  'UID': id,
                                });
                                print(res.documentID);
                                Fluttertoast.showToast(
                                    msg: "Registration Successful",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIos: 1,
//                                      backgroundColor: Colors.whi,
//                                      textColor: Colors.white,
                                    fontSize: 10.0);
                              } else {
                                print('registered');
                                DocumentReference res = await _firestore
                                    .collection('Account Details')
                                    .add({
                                  "Account Holder's name": name,
                                  "Account Number": accno,
                                  "IFSC Code": ifsc,
                                  'UID': id,
                                });
                                print(res.documentID);
                                Fluttertoast.showToast(
                                    msg: "Registration Successful",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIos: 1,
//                                      backgroundColor: Colors.whi,
//                                      textColor: Colors.white,
                                    fontSize: 10.0);
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChequePick(id)),
                              );
                            }
                          },
                          color: Colors.green,
                        ),
                      ),
                    ]))),
          ),
        ]));
  }
}
