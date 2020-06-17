import 'dart:convert';

import 'package:delilo/Screens/authenticate/Bank_Details.dart';
import 'package:delilo/utils/buttons.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gst_verification/gst_verification.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:delilo/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BusinessDetails extends StatefulWidget {
  String id;
  BusinessDetails(this.id);
  @override
  _BusinessDetailsState createState() => _BusinessDetailsState(this.id);
}
enum SingingCharacter { first, second,third }

final _firestore = Firestore.instance;
final _auth = FirebaseAuth.instance;
final AuthService _auth1 = AuthService();

class _BusinessDetailsState extends State<BusinessDetails> {
  String id;
  _BusinessDetailsState(this.id);
  SingingCharacter _character = SingingCharacter.first;
  @override  Widget build(BuildContext context) {
    String hint="";
    int _radioValue = 0;
    bool check = false;
    String gstNo, key_secret="Uzq0K7Ak1vaXiXa8Ban4owtyHrK2", response = '';

    double valueOp = 0;

    void verifyGSTNumber() {
      print(gstNo + " , " + key_secret);

      valueOp = 1;

      GstVerification.verifyGST(gstNo, key_secret).then((result) {
        JsonEncoder encoder = new JsonEncoder.withIndent('  ');
        String prettyprint = encoder.convert(result);

        print(prettyprint);

        response = "JSON Response:\n\n" + prettyprint;
        print(response);
        valueOp = 0;
        setState(() {
          check = true;
          Fluttertoast.showToast(
              msg: "GSTIN Verified !",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
//                                      backgroundColor: Colors.whi,
//                                      textColor: Colors.white,
              fontSize: 10.0);
        });
      }).catchError((error) {
        print(error);
        valueOp = 0;
        setState(() {
          check = false;
          Fluttertoast.showToast(
              msg: "Invalid GSTIN !",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
//                                      backgroundColor: Colors.whi,
//                                      textColor: Colors.white,
              fontSize: 10.0);
        });
      });
    }

    _draw(BuildContext context)
    {
      if(_character==SingingCharacter.first)
        {
          return TextFormField(
            decoration: InputDecoration(
                hintText: 'GSTIN Number',
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                suffixIcon: FlatButton(
                  onPressed: (){
                      verifyGSTNumber();
                  },
                  child: Text("Verify",style: TextStyle(color: Colors.green,),),
                )
            ),
            onChanged: (val) {
              setState(() => gstNo = val);
            },
          );
        }
      else
        {
          return SizedBox(height: 1,);
        }
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
            child: SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height),
                    child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 2,
                          ),
                          Container(
                            height: 150,
                            width: 200,
                            decoration: BoxDecoration(
                              image:DecorationImage(
                                  image: AssetImage('images/logo.png')),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "  GIVE YOUR BUSINESS DETAILS  ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 26,
                          ),
                          ListTile(
                            title:Text("I Have a GSTIN"),
                            leading: Radio(
                              value: SingingCharacter.first,
                              activeColor: Colors.green,
                              groupValue: _character,
                              onChanged: (SingingCharacter value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            title:Text("I will only sell in GSTIN exempt \ncategories like books"),
                            leading: Radio(
                              value: SingingCharacter.second,
                              activeColor: Colors.green,
                              groupValue: _character,
                              onChanged: (SingingCharacter value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            title:Text("I have applied/will apply for GSTIN"),
                            leading: Radio(
                              value: SingingCharacter.third,
                              activeColor: Colors.green,
                              groupValue: _character,
                              onChanged: (SingingCharacter value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          _draw(context),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: 180,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle
                            ),
                            child: RoundButoon(
                              name:"Continue",
                              f: () async{
                                if(_character==SingingCharacter.first)
                                  {
                                    if(check==false)
                                      {
                                        Fluttertoast.showToast(
                                            msg: "Invalid GSTIN !",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIos: 1,
//                                      backgroundColor: Colors.whi,
//                                      textColor: Colors.white,
                                            fontSize: 10.0);
                                      }
                                    else
                                      {
                                        try {
                                          print('registered');
                                          DocumentReference res = await _firestore.collection('GSTIN Details').add({
                                            'GSTIN': gstNo,
                                            'UID' : id,
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
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => BankDetails(id)),
                                          );
                                        }
                                        catch (e)
                                        {
                                          print(e);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => BusinessDetails(id)),
                                          );
                                        }
                                      }
                                  }
                                else
                                  {
                                    print('registered');
                                    DocumentReference res = await _firestore.collection('GSTIN Details').add({
                                      'GSTIN': null,
                                      'UID' : id,
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                        builder: (context) => BankDetails(id)),
                                    );
                                  }

                              },
                              color: Colors.green,
                            ),
                          ),
                        ]
                    )
                )
            ),
          ),
        ]
        )
    );
  }
}
