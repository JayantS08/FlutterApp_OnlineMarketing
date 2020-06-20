import 'package:delilo/Screens/owner_home/owner_items/fashion.dart';
import 'package:delilo/Screens/owner_home/owner_items/kids.dart';
import 'package:delilo/Screens/owner_home/owner_items/men.dart';
import 'package:delilo/Screens/owner_home/owner_items/women.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../services/auth.dart';
import '../owner_additems.dart';


class OwnerMenu extends StatefulWidget {
  String id;
  OwnerMenu(this.id);
  @override
  _OwnerMenuState createState() => _OwnerMenuState(id);
}

class _OwnerMenuState extends State<OwnerMenu> {

  String id;
  _OwnerMenuState(this.id);

  List <String> filteritem = ['All items', 'Out of stock'];
  List <String> categories = ['Fashion', 'Men', 'Women', 'Kids'];
  List <int> itemCategory = [122,65,100,213];



  int categoryIndex = 0;

  List <Widget> categoryPage = [OwnerFashion(), OwnerMen(), OwnerWomen(), OwnerKids()];

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


  int _filterValue = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: <Widget>[
          Container(
//            color: Colors.blue,
            child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                children: List<Widget>.generate(
                    2,
                        (int filterindex){
                      return ChoiceChip(
                        label: Text(filteritem[filterindex]),
                        selected: _filterValue == filterindex,
                        onSelected: (bool isSelected){
                          setState(() {
                            _filterValue = isSelected ? filterindex : null;
                          });
                        },
                      );
                    }
                ).toList()
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            height: 400,
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                  color: Colors.white,
                  child: ListTile(
                      title: Text(categories[index]),
                      trailing: FlatButton(
                        onPressed: () {
                        },
                        child: Text('Edit'),
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          Text('${itemCategory[index]} items'),
                          Icon(Icons.keyboard_arrow_down)
                        ],
                      ),
                    onTap: () {
                      print(index);
                      Navigator.push(context, MaterialPageRoute(builder: ((BuildContext context) => categoryPage[index]) ));
                    },
                  ),
                );

              },
            ),
          ),
          Center(
            child: RaisedButton(
              padding: EdgeInsets.fromLTRB(45,15,45,15),
              shape: StadiumBorder(),
              color: Colors.greenAccent,
              child: Container(
                color: Colors.greenAccent,
                child: Text('Add New'),
              ),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: ((BuildContext context)=> OwnerAddItem()))),
            ),
          ),
        ],
      ),
    );
  }

  void _dialog(BuildContext context)
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Select the category name or create new one."),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _name,
                ),
                SizedBox(height: 10,)
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

}
