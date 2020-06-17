import 'package:delilo/utils/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DelHome extends StatefulWidget {
  @override
  _DelHomeState createState() => _DelHomeState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
bool _autoValidate = false;

class _DelHomeState extends State<DelHome> {
  String name = '#####';
  String orderid = '#####';
  String mode = '#####';
  String Address = '#####';
  String Address2 = '#####';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("images/back.png"),
              fit: BoxFit.cover,
            )),
          ),
          Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(
                              height: 120,
                            ),
                            Text(
                              "Welcome ",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 34),
                            ),
                            Text(
                              name,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 34),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 5,
                            ),
                            FlatButton(
                              color: Colors.grey,
                              splashColor: Colors.green,
                              child: Text("New Order"),
                              onPressed: (){

                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            FlatButton(
                              color: Colors.grey,
                              splashColor: Colors.green,
                              child: Text("Active Order"),
                              onPressed: (){

                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            FlatButton(
                              color: Colors.grey,
                              splashColor: Colors.green,
                              child: Text("Past Order"),
                              onPressed: (){

                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 5,
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 10,),
                              Text(
                                orderid,
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 45,
                                  ),
                                  FlatButton(
                                    color: Colors.grey,
                                    splashColor: Colors.green,
                                    child: Text("Pickup"),
                                    onPressed: (){

                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50)),
                                  ),
                                  SizedBox(
                                    width: 45,
                                  ),
                                  FlatButton(
                                    color: Colors.grey,
                                    splashColor: Colors.green,
                                    child: Text("Delivery"),
                                    onPressed: (){

                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  SizedBox(width: 35,),
                                  Text(
                                    'Payemnt Mode : ',
                                    style: TextStyle(color: Colors.green,fontSize: 18),
                                  ),
                                  Text(
                                    mode,
                                    style: TextStyle(color: Colors.green,fontSize: 18),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  SizedBox(width: 10,),
                                  Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        image: AssetImage("images/lll.png"),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    Address,
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.pin_drop),
                                    tooltip: 'Locate Address',
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.phone),
                                    tooltip: 'Place a call',
                                    onPressed: () {},
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              Text("Deliver To : ",textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: <Widget>[
                                  SizedBox(width: 10,),
                                  Text(
                                    Address2,
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.pin_drop),
                                    tooltip: 'Locate Address',
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.phone),
                                    tooltip: 'Place a call',
                                    onPressed: () {},
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        RaisedButton(
                          onPressed: () {},
                          color: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Text("Order Delivered"),
                        )
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
