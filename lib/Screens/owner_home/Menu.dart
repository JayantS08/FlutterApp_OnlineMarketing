import 'package:delilo/Screens/Buyer_home/BuyToys&Baby.dart';
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

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

final _item = TextEditingController();
final _name = TextEditingController();

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
bool _autoValidate = false;
String _value;
final _firestore = Firestore.instance;
final _auth = FirebaseAuth.instance;
var newname = '';
var newitem = 0;
var name = new List(100);
var items = new List(100);
var date = new List(100);
int n = 0;
final AuthService _auth1 = AuthService();
var otp = new List(6);
bool check = false;

void _dialog(BuildContext context)
{
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Give the name and items"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _name,
              ),
              SizedBox(height: 10,),
              TextField(
                controller: _item,
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Confirm"),
              textColor: Colors.white,
              color: Colors.green,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular((50))),
              onPressed: (){
                name[n+1]=_name.text.trim().toString();
                items[n+1]=_item.text.trim().toString();
                n++;
                Navigator.of(context);
              },
            )
          ],
        );
      });
}

Widget _draw() {
  Widget btnWidget = Container();
    // If image is picked by the user then show a upload btn
    btnWidget = Container(
      child: Column(
        children: <Widget>[
          for(int i=0;i<n;i++)
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(name[i],style: TextStyle(color: Colors.green,fontSize: 20),),
                        FlatButton(
                          child: Text("Edit"),
                          onPressed: (){

                          },
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(items[i],style: TextStyle(color: Colors.black,fontSize: 10),),
                        Text("items",style: TextStyle(color: Colors.green,fontSize: 10),),
                        Icon(Icons.arrow_drop_down)
                      ],
                    )
                  ],
                ),
              ),
        ],
      ),
    );
  return btnWidget;
}

class _MenuPageState extends State<MenuPage> {
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
            "MENU",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          _draw(),
          RoundButoon(
            name: "Add New",
            f: (){
              n++;
              _dialog(context);
            },
            color: Colors.green,
          ),
        ]
    )
    );
  }
}
