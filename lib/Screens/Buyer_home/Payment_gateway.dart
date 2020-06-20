import 'package:delilo/Screens/Buyer_home/ordered.dart';
import 'package:flutter/material.dart';

class Payment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green,
      ),
      body: PaymentPage(),
    );;
  }
}

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
          child: SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery
                        .of(context)
                        .size
                        .height),
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 30,),
                        Text("Select your payment method ",
                          style: TextStyle(color: Colors.green, fontSize: 20),),
                        SizedBox(height: 30,),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 5,
                          color: Colors.white,
                          child: InkWell(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  width: 85,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('images/card.png')),
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Text("Credit or Debit Card")
                              ],
                            ),
                            onTap: (){
                              print("Credit Card");
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Ordered()),
                              );
                            },
                          ),

                        ),
                        SizedBox(height: 15,),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 5,
                          color: Colors.white,
                          child: InkWell(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  width: 85,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('images/upi.png')),
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Text("UPI")
                              ],
                            ),
                            onTap: (){
                              print("UPI");
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Ordered()),
                                );
                              });
                            },
                          )
                        ),
                        SizedBox(height: 15,),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 5,
                          color: Colors.white,
                          child: InkWell(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  width: 85,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('images/paytm.png')),
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Text("Paytm")
                              ],
                            ),
                            onTap: (){
                              print("Paytm");
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Ordered()),
                              );
                            },
                          )
                        ),
                        SizedBox(height: 15,),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 5,
                          color: Colors.white,
                          child: InkWell(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  width: 85,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('images/gpay.png')),
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Text("Google Pay")
                              ],
                            ),
                            onTap: (){
                              print("gpay");
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Ordered()),
                              );
                            },
                          )
                        ),
                        SizedBox(height: 15,),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 5,
                          color: Colors.white,
                          child: InkWell(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  width: 85,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('images/cash.png')),
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Text("Cash on Delivery")
                              ],
                            ),
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Ordered()),
                              );
                              print("Cash");
                            },
                          )
                        ),
                        SizedBox(height: 15,),
                      ],
                    ),
                )

            ),
          ),
        )
      ],
    );
  }
}

