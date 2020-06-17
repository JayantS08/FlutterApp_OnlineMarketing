import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuyerProfile extends StatefulWidget {
  @override
  _BuyerProfileState createState() => _BuyerProfileState();
}

class _BuyerProfileState extends State<BuyerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Center(child: Text("My Account",style: TextStyle(color: Colors.white),)),
        backgroundColor: Colors.green,
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){}),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.notifications,color: Colors.white,), onPressed: (){}),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius:50,
                          backgroundImage: AssetImage("images/NoPath - Copy.png"),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 90,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green,
                            style: BorderStyle.solid,
                            width: 0.7,
                          ),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: MaterialButton(
                          onPressed: (){},
                          child: Text(
                            "Change",
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                      child: Text("John Doe",style: TextStyle(color: Colors.green,fontSize: 20),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                      child: Text("+91 987654331",style: TextStyle(fontSize: 17),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                      child: Text("email@address.com",style: TextStyle(fontSize: 17),),
                    ),
                    SizedBox(height: 10,)
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Address",style: TextStyle(color: Colors.green,fontSize: 15),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                      child: Text("New Delhi, Delhi,India, Earth, Milkyway Galaxy, Universe, PIN-###########",style: TextStyle(fontSize: 17),),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(width: 10,),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.green,
                            child: Icon(Icons.check,color: Colors.white,),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
