import 'dart:math';

import 'package:flutter/material.dart';

class Gateway extends StatefulWidget{
  @override
  _GateWayState createState() => _GateWayState();
}

class _GateWayState extends State<Gateway>{
  List<String> items = new List.filled(4, 'Item');

  int Discount = 0;
  int totalAmount =0;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Pay for your order"),
        backgroundColor: Colors.green,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody(){

    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            
            ListTile(
              title: Text('Item Name'),
              trailing: Text('Cost in Rupees'),
              leading: Text("S.no"),
            ),
            SingleChildScrollView(
              child: Container(
                height: 400,
                child: ListView.separated(itemBuilder: (BuildContext context,int index){
                  totalAmount = totalAmount + index*215;
                  print('Total amount == $totalAmount');
                  return ListTile(
                    title: Text(items.elementAt(index).toString()),
                    trailing: Text((index*215).toString()),
                    leading: Text(index.toString()),
                  );

                }, separatorBuilder: (BuildContext context,int index) => Divider(), itemCount: items.length),
              ),

            ),
          ListTile(
            onTap: (){
              setState(() {

              });
            },
            title: Text('Discount in Rupess'),
            trailing: Text(Discount.toString()),
          ),

            ListTile(
            title: Text("Grand Total"),
            trailing: Text(totalAmount.toString()),
          ),


            Row(
            children: <Widget>[
              SizedBox(
                width: 10,
              ),

              Container(
                color: Colors.green,
                child: SizedBox(

                  width: 150,
                  child: FlatButton(child: Text('Pay with RazorPay'),),
                ),
              ),
              SizedBox(
                width: 40,
              ),
              Container(
                color: Colors.red,
                child: SizedBox(
                  width: 150,
                  child: FlatButton(child: Text('Pay with Google Pay',),),
                ),
              )
            ],
          )
          ],
        ),
      ),
    );
  }

}