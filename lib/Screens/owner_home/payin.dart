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

class Payin extends StatefulWidget {
  @override
  _PayinState createState() => _PayinState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
bool _autoValidate = false;
String _value;
final _firestore = Firestore.instance;
final _auth = FirebaseAuth.instance;
var product = new List(100);
var amount = new List(100);
var date = new List(100);
int n = 0;
final AuthService _auth1 = AuthService();
var otp = new List(6);
bool check = false;

class _PayinState extends State<Payin> {
  @override
  Widget build(BuildContext context) {
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
          Text(
            "PAYIN",
            style: TextStyle(color: Colors.green, fontSize: 20),
          ),
          Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 10,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                              child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Product",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Amount",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Date",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    for(int i=0;i<n;i++)
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          Text(product[i]),
                          SizedBox(
                            width: 10,
                          ),
                          Text(amount[i]),
                          SizedBox(
                            width: 10,
                          ),
                          Text(date[i]),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )

                  ],
                ),
              )),
        ]));
  }
}
