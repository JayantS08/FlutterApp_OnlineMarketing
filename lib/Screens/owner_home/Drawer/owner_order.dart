import 'package:delilo/Screens/owner_home/owner_accept_orders.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../services/auth.dart';

class OwnerOrder extends StatefulWidget {
  @override
  _OwnerOrderState createState() => _OwnerOrderState();
}

class _OwnerOrderState extends State<OwnerOrder> {
  String ownId;
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
  int n = 1;
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
if(name[i].toString().toLowerCase()=='order'){
  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>AcceptOrders(ownId??'id'),
                ));
}
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


  @override
  Widget build(BuildContext context) {
    return _draw();
  }
}


