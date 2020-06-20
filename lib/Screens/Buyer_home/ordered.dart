import 'package:delilo/Screens/Buyer_home/Buyer_Initialpage.dart';
import 'package:flutter/material.dart';

class Ordered extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: EdgeInsets.only(left: 60,right: 30,top: 40),
        child: Column(
          children: <Widget>[
            Expanded(child:Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 5,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/dello14.png')),
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(width: 20,),
                  Text("    Ordered Successfully   ",style: TextStyle(color: Colors.green,fontSize: 27),),
                  SizedBox(width: 20,),
                  SizedBox(height: 20,),
                  SizedBox(width: 20,),
                  Text("    Thank You So much\n            for ordering    ",style: TextStyle(color: Colors.black,fontSize: 20),),
                  SizedBox(width: 20,),
                  SizedBox(height: 20,),
                  RaisedButton(
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        'Check Status',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {

                      }
                  ),
                ],
              ),
            ), ),

            SizedBox(height: 100,),
            RaisedButton(
                color: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  'Continue Shopping',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BuyerInitPage()),
                  );
                }
            ),
          ],
        ),
      )
    );
  }
}
